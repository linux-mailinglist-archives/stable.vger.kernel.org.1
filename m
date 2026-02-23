Return-Path: <stable+bounces-217732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AkhJF87nGlCBgQAu9opvQ
	(envelope-from <stable+bounces-217732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:34:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D93175945
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D679B3022592
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC90364050;
	Mon, 23 Feb 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xn7s50xX"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A86361DB6
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846487; cv=none; b=GhHBPUQ4Q/GIlYSj3DcrKptaoc3cMan9VVCpWFWm0BoUv9FZzmQFtBpEkV+RLt98EpAlzTsCmTvxVeOsUaJnXCUMPLD6KFMTVXkhJuKR25AesHqrEFl9vIGFXjwRj0mu7SyCYgHdE8XbzTG2+BTEUIVWYJ+3juba7CLkgcNXOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846487; c=relaxed/simple;
	bh=7fAYU0EC6HGaMeNuZ+agw5h+FPH+Nx+nkFQ0d7C5fJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNFLzvZyGuZ0BPa2hs+e0s//zFym1zegP2O7WYdWbKnPB/IA6/Y0EX2Mt7iIohHiemQL66rEqF1Zqvvo1xKaF4iu+mBSJ/jy2FLZe+xvnB8VGlDOEvaHafcB2/R1/sMTk5epw08pDvVzypKff+e2oxuSXBkakQeEagmyWyFX+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xn7s50xX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7fAYU0EC6HGaMeNuZ+agw5h+FPH+Nx+nkFQ0d7C5fJM=;
	t=1771846485; x=1773056085; b=xn7s50xXf6MGhShWta7odJgyOtz+v5O1JD4kZCc+eKgeHV+
	34zGB4NMOpgvlvPc8FQ6/wypdsLPFJNIqc+PxWaU25zFFBkombVgJ/sivIi9nhZsQS2hZ2hHCcx4n
	lolLFXOu7FbGX5IFvHgfahoIYsLg5eIgr4JoLcqAk0dIDlJ8mM+Nr5R7aVFqIPg3uFDlwnrAO1Zzt
	prXMkoiJnIs3Swr2gjmVKpBOcS8XIIIZ8NuOFahln3GqG/JnL7ifdVdcXAT5Ar3YOx5umxipn7yE+
	s6VXFSrC7wuTONYdjdYt8/tn8dqTeS9I2ku0Hgdqd7YBkyx03D8bbHTWLxMW0/Lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuUD4-0000000H0lo-0dLA;
	Mon, 23 Feb 2026 12:34:42 +0100
Message-ID: <1508c79ec227bb8b56fee7d6c0ef1fb6ee8bd456.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: bounds-check link_id in
 ieee80211_ml_reconfiguration
From: Johannes Berg <johannes@sipsolutions.net>
To: cr-ArielSilver <arielsilver77@gmail.com>
Cc: torvalds@linuxfoundation.org, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Date: Mon, 23 Feb 2026 12:34:41 +0100
In-Reply-To: <20260220101129.1202657-1-Ariel.Silver@cybereason.com> (sfid-20260220_111201_171491_4EBBF3CA)
References: 
	<0fdab034a93626704d84eefbda652f5bfcbeac7e.camel@sipsolutions.net>
	 <20260220101129.1202657-1-Ariel.Silver@cybereason.com>
	 (sfid-20260220_111201_171491_4EBBF3CA)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217732-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5D93175945
X-Rspamd-Action: no action

On Fri, 2026-02-20 at 10:11 +0000, cr-ArielSilver wrote:
> From: Ariel Silver <arielsilver77@gmail.com>
>=20
> link_id is taken from the ML Reconfiguration element (control & 0x000f),
> so it can be 0..15. link_removal_timeout[] has IEEE80211_MLD_MAX_NUM_LINK=
S
> (15) elements, so index 15 is out-of-bounds. Skip subelements with
> link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS to avoid a stack out-of-bounds
> write.
>=20
> Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfig=
uration ML element")
> Reported-by: Ariel Silver <arielsilver77@gmail.com>
> Signed-off-by: Ariel Silver <arielsilver77@gmail.com>

I'll apply this anyway, but ...

> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -7073,6 +7073,10 @@ static void ieee80211_ml_reconfiguration(struct ie=
ee80211_sub_if_data *sdata,

How did this line happen? You're only adding 3 new lines. How is it even
_possible_ to get this wrong?!

johannes

