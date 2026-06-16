Return-Path: <stable+bounces-263491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RR81FlOSMGpUUgUAu9opvQ
	(envelope-from <stable+bounces-263491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FC68AC23
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=r26.me header.s=protonmail2 header.b=kJOwiA37;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263491-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263491-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=r26.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A54A3020862
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82967274B46;
	Tue, 16 Jun 2026 00:01:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBE37703B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:00:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568062; cv=none; b=DgzzS8OnFcIdtVu7S8ppM/EVYYLHJiaOmc2Yehy/lLZSSWURfYl3XbEXFYsalWU3e/rkvLbNfGLK4/Bp/kzdz43vro0A6UgV5106fw3u0o27fNW9pONJm+MkUfrqchBcu59DQp0cWN60l88yTMKvpilgPc379Ca7Pfn/pMP7dAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568062; c=relaxed/simple;
	bh=FJ3O/SbKr/fRN9XU1atcPtYUqqUMiw1B5KQ0KtVMNgc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=CE6f69cPfT5//GpIkPjly5etxfv/hbNHvuCLmnYCNRxDoNL9ufA5DiwCIIHr3nPPCFtvvKCuuWAAc7vozqiIwblrPgwtLchf1iVCgyQMREmVItoW6OD1dyAHXAtHKZcVyPM1dA/Vo3yhVP+0aufEdrkrvHeQpV/bHjKpmyOqheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=kJOwiA37; arc=none smtp.client-ip=109.224.244.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail2; t=1781568051; x=1781827251;
	bh=FJ3O/SbKr/fRN9XU1atcPtYUqqUMiw1B5KQ0KtVMNgc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kJOwiA37sS3+hHuencbb9Wu5VdalWt0p52dVIgd5kurApbGgcUqvoxAzwYSonObkp
	 f7EvdSVEn1Y/mqv5OBz13rD8MZiB0iQYNaBWDTNXtsHMVgOwA8GGiSpqEHHb0HqAAQ
	 mGXEqQCo4xgSoJSGAw0BKAKaWvm0DtRC29fIJgnX85v2t6iUDv3FaT8vwkBxYmPM4h
	 29Sl/Y2yoQEP7ITn+DJ89teEfFJamagtGNtQaYqbAcfC0BQpu8RF4idSGKO9MazHRo
	 6FOhemPSLban0ioMuRp+lASV/kjNnwYb8FBpWOv4qXDqdezVvYjUBj3TSF/ZFPBou8
	 OCwKTL5ePXS3Q==
Date: Tue, 16 Jun 2026 00:00:47 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Rio Liu <rio@r26.me>
Subject: [stable request 6.18+] wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode
Message-ID: <mCC83on9NUv38GIhB5hQoC8aXh1aZOeWWXh2010h2l8b0-rPJJKWIJvfPu4AZyATnaJuANDDndSZtpVC7_aQeArt435TQjshtrw9PUL2o5k=@r26.me>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: 5f1ba02fb5900eacd1d5718a984320ae8b0b34f1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[r26.me,none];
	R_DKIM_ALLOW(-0.20)[r26.me:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rio@r26.me,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rio@r26.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[r26.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,r26.me:dkim,r26.me:mid,r26.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71FC68AC23

Hello,

I'd like to include the following two commits to v6.18 and above:

711a9c018ad2 ("wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support che=
ck in non-strict mode")
0cfff13c94cb ("wifi: mac80211: tests: mark HT check strict")

There was some recent changes in Xfinity router firmware that limits wifi
bandwidth in some cases. The patches add a workaround to get back full spee=
d
against these routers. I forgot to CC stable in the initial patch submissio=
n
but I see no reason why the fix be limited to the latest kernel.

Verified these two cherry-picks succesfully against v6.18.35 and v7.0.12.

Rio

