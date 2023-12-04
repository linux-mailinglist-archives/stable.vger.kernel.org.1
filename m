Return-Path: <stable+bounces-3978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C217C804057
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB46281328
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8812FC25;
	Mon,  4 Dec 2023 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H/WMcxmV"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23F1AA;
	Mon,  4 Dec 2023 12:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IzuQejDpRVhj/RMqVK3vOEQVqngyGrm2sTvalLaOwLg=;
	t=1701722759; x=1702932359; b=H/WMcxmV0wxRurMtewK+gpNJ/8Evke2GSY/JzvBZXuAB3+k
	v7s6xENb+LIx4zVJ4QnBTH+DkSd2MSOaJSpSgto22gS+wVb3ebOwE4Wg1MeFhCLWElq2SA35UedNt
	Cn4h6RIIwi/EhXVdqmjZoN43yvd+Xu1UgGHqIbjbSQT8dKbWc8KMORFOGwKFSH9C3jUx8LC2Ufboe
	VMZmlXuPkxqKrZiI/4TkOLhlQCX9Uc4hG7qWABRmNaiIHR2/m8MK960em7hBcwe7/fVWFEIyztOpk
	JbnPaY+FUkz7nPsNdPdjQfyv6QO32nR9n+6vD0i8UaMBITexKH/uhhzNd9UvuCAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAFpE-0000000FFfd-2z3a;
	Mon, 04 Dec 2023 21:45:57 +0100
Message-ID: <1a7a8caa3fe9b4e3271239b86ebd24a41464b79f.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 6.6 15/32] debugfs: annotate debugfs handlers
 vs. removal with lockdep
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 04 Dec 2023 21:45:55 +0100
In-Reply-To: <20231204203317.2092321-15-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
	 <20231204203317.2092321-15-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 20:32 +0000, Sasha Levin wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> [ Upstream commit f4acfcd4deb158b96595250cc332901b282d15b0 ]
>=20
> When you take a lock in a debugfs handler but also try
> to remove the debugfs file under that lock, things can
> deadlock since the removal has to wait for all users
> to finish.
>=20
> Add lockdep annotations in debugfs_file_get()/_put()
> to catch such issues.
>=20

This (and the previous patch) probably got picked up as dependencies for
the locking things, but ... we reverted this.

For 6.6, _maybe_ it's worth backporting this including the revert, but
then I'd do that only when the revert landed to have them together. But
then you should apply all the six patches listed below _and_ the revert,
the set as here doesn't do anything useful.

However ... given that debugfs is root-only, and you have to be
reading/writing a file _while_ disconnecting and the file is removed,
perhaps the whole thing isn't worth backporting at all.



For 6.1 and earlier, I believe it's not needed at all, so please drop
from there all of these:

 - debugfs: fix automount d_fsdata usage
 - debugfs: annotate debugfs handlers vs. removal with lockdep
 - debugfs: add API to allow debugfs operations cancellation
 - wifi: cfg80211: add locked debugfs wrappers
 - wifi: mac80211: use wiphy locked debugfs helpers for agg_status
 - wifi: mac80211: use wiphy locked debugfs for sdata/link


I'd kind of think just dropping all of these completely makes more
sense.

johannes

