Return-Path: <stable+bounces-244356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLR5F6cM+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:40:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B20944D8C2C
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DF53050C85
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76693E9582;
	Wed,  6 May 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJCJ73jU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FA3DC4C9;
	Wed,  6 May 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060084; cv=none; b=fpkQg+l+Lw/EuG/25j09x0bJvrkGabZKU1VhnmxR0mUTX3MD/rLKuy6ceH2zIR9JH7PADH3x7K7NmRosONzkaqSgHkNLYMPE6ojaN6d5mzisK2vPYftRQkJQP9XCFWdsfiMvaO6R6+c+mP5qMVkkb+NEmwcG8WbrsJiD60exzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060084; c=relaxed/simple;
	bh=WZ6JxE0NUFREJzUiSy3sA/H5nRl3edihesTlnyUr5NU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rEoLpGUClw1SR6HGcm2DpeMp4ZuH7ep2L3y/PpWIU0tXLISU/uY8RjhfeApU6nC3a9XA9JGI7uVkngPfRhQXFtaQ8+/T3XxHsuT9bWNTuiEDZcisFwKwaa6nZvtWv7zJDPLKY8Hi5UKk9IN8kFPBpWf4aiyKbceKwb81OsVhS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJCJ73jU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E39AC2BCB8;
	Wed,  6 May 2026 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778060084;
	bh=WZ6JxE0NUFREJzUiSy3sA/H5nRl3edihesTlnyUr5NU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uJCJ73jU2ZZnuZTW3QKWixyJ2iQY2wgJGiEmapdpnDQAZOEkDx6n4uYGtf/9sXnHj
	 rIs+C/xnB0RyZTRzxtj4H4Rqqzxj/fBh9/vOiSp7YK0tZIwPLQVKg/lJRnPAmfL7rg
	 D8AU1MuSjWiM0YBm2oeQCgr9YEIgYll6iYwrAhz1Lf1wz8+MA9yvPpFtfKdzDCf0y8
	 NgQSfojMvKj4bhbcPjVdp4Ap4LuWAnSYIKjcMNbN7V3vEibT/VYKYOXnOHnzIXxpJE
	 hh1sy+qA/unaXbhYn7iATcWf7ISHPCCMtDzOmCrhC0QYqTzkSHbjlPT9vE5mc8kHiW
	 b/3EfgUXhYeAw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 11:34:39 +0200
Message-Id: <DIBHP03H2703.3GVN744LMKNQ1@kernel.org>
Subject: Re: [PATCH v4 0/2] firmware_loader/ALSA: Fix TAS2781 async firmware
 teardown
Cc: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Takashi Iwai" <tiwai@suse.com>, "Shenghao Ding"
 <shenghao-ding@ti.com>, "Kevin Lu" <kevin-lu@ti.com>, "Baojun Xu"
 <baojun.xu@ti.com>, "Jaroslav Kysela" <perex@perex.cz>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, <stable@vger.kernel.org>
To: "Takashi Iwai" <tiwai@suse.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com> <874iklt12t.wl-tiwai@suse.de>
In-Reply-To: <874iklt12t.wl-tiwai@suse.de>
X-Rspamd-Queue-Id: B20944D8C2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,linuxfoundation.org,suse.com,ti.com,perex.cz,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244356-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]

On Wed May 6, 2026 at 10:05 AM CEST, Takashi Iwai wrote:
> On Tue, 05 May 2026 13:18:15 +0200,
> C=C3=A1ssio Gabriel wrote:
>> C=C3=A1ssio Gabriel (2):
>>       firmware_loader: Add cancel helper for async requests
>>       ALSA: hda/tas2781: Cancel async firmware request at unbind

Looks good to me now.

> I guess this could go via driver tree?  Or I can take both if I get an
> ack, too.

Sure, I can pick it up via the driver-core tree, but please also feel free =
to
take it through the sounds tree.

Acked-by: Danilo Krummrich <dakr@kernel.org>

> In anyway, for the series:
>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

