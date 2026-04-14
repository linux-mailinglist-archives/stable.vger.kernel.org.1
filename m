Return-Path: <stable+bounces-237851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGkZAygv3mnxogkAu9opvQ
	(envelope-from <stable+bounces-237851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:12:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2463F9DCB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 465C93093990
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267233E51F8;
	Tue, 14 Apr 2026 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtPaK+tV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3913C3C01
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168518; cv=none; b=aGRfOVOt6Q2ek9Db1aa0sikr8mY/ssmHLV2TIKNhAKUCgs66z2xEXp8y8VYbcqqrh2sIczITSF8pTv3S9ejBXBvjY1EjWwFs4i9NJRuqbo6Rgc90iPXaGArDUlDLSZ9DJWXvv9TtMMJfwvsDaiLXaZ6TsMa147MrDNUHDVxne1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168518; c=relaxed/simple;
	bh=sbIT42EO48h9I3vHmV2+sglBcE0YKQmhG8A9pkTlv1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXzli4j3NQbrN/P5wnapDLXQ43iMHk5r5NJ/KUynW1pffqnbVwe6ol7UAsJPpDoRIKtdK00S4kDbY+AcnQ9/qyQ1We8XCf/dMVGf9uWN3MTdcjpggHQyFrPBtOf4UvqrVISyWzR+//MSi5wB7DcJ0z2jQUF6Z+qgMFm2UQ8aP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtPaK+tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26205C19425;
	Tue, 14 Apr 2026 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776168518;
	bh=sbIT42EO48h9I3vHmV2+sglBcE0YKQmhG8A9pkTlv1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtPaK+tVnuQ8+j0qdL2Pwjg/ghaiFfBcGwzXzEsAbGa3+VdZcT+/GWOJYhdpsjjUd
	 pGmqMAMrZlJLMMXY2rFjPeN2A65NfIUXU1j5IO8GLmStda0GgMGAGl9qKjfKMHavH9
	 osCM2gUml4fNnuCbbKKbVdOpni12tRfCa7ipoF+UaOm91GpU+N+j75KK8O+VFvYUgN
	 elEg1RLGMGqUgcBqpmiRW3ELXpL00guZ/VmMf6cUWf56yWs/HxJeBvrHx7laEaEdj8
	 uDCEW8zqeCM5HFw8lN1w/z4Hc2MGsgkBGfdrC8zX75eFtWQ5NAEb/sOFOAiKuIsaIu
	 9b2R4R8vzuDfA==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 5.10 474/491] mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
Date: Tue, 14 Apr 2026 08:08:37 -0400
Message-ID: <20260414120837.580198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPDyKFo1DWRbidKrMg+DkwOxsdzDrfF5+YVhjjzGZzkAC7=Yfg@mail.gmail.com>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155836.794775290@linuxfoundation.org> <65cd5a0b7c68af467b8b13b4fbce51cc2febb5ad.camel@decadent.org.uk> <CAPDyKFo1DWRbidKrMg+DkwOxsdzDrfF5+YVhjjzGZzkAC7=Yfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237851-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC2463F9DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 14 Apr 2026, Ulf Hansson wrote:
> Yes, good point, this commit is needed as well!

The companion fix (406e14808ee6) doesn't apply cleanly to 5.10, so I've
dropped this patch and its dependency chain from the 5.10 queue instead.

Thanks for the review.

