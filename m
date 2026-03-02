Return-Path: <stable+bounces-222721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLdMNGUOpmmFJgAAu9opvQ
	(envelope-from <stable+bounces-222721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:25:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3F1E5527
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD5E53224286
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F603914ED;
	Mon,  2 Mar 2026 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="Dbi5LEw4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-172.mimecast.com (us-smtp-delivery-172.mimecast.com [170.10.129.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54A355814
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484809; cv=none; b=Ma7lDQAzpzFDFlxv09lZO1LdNEgHa991IvvY9VI/64PCGJZgPGYJdG1zSFlodzoJ0hZpxtu1DHvi58qj4MgdjIPN+e5nnnt9arRUGUjEGfAOQkpWDCrE+n2uiNFX9fNlH0ry94LcOPeYhKdHMsKDJ0E1qvb1SBc7uR5NHRI1rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484809; c=relaxed/simple;
	bh=16uxkWL5hX4j7KosRvOHcNcAEDOs7nmqZeye1nOhNDg=;
	h=Date:Message-ID:CC:Subject:From:To:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Qt7W8Shc/yi6Kxwv8HVFhVT4VS5/cCKoEd6nuXnYXn7QlTlhVH0CLWpU6IZSRclQDGy3vakBQ3G4opS+OmNCt3r4u1o8rvol6Kazzx1ftNLw5upzLAlWW7rjE3iO6eBjZJOnJ5OQ9hB3wK6CRyjJK+hAunlmr4mTp8nndj2e2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com; spf=pass smtp.mailfrom=valvesoftware.com; dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b=Dbi5LEw4; arc=none smtp.client-ip=170.10.129.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valvesoftware.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
	s=mc20150811; t=1772484806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16uxkWL5hX4j7KosRvOHcNcAEDOs7nmqZeye1nOhNDg=;
	b=Dbi5LEw4en0dZ9luuvKYVAVeFC85iku3CAkI8zZ8HJ5+tOM/jOQxGhkh6tTXUO3ILHfE+A
	nipqibx+NQhyRBN1F2UqIgGvX8Yq/UT5dZbgoy8Bxdo453pjNp3BxVQMyqhPYq/6MGCyyb
	g7xFgU+khNsZowXgdrhAsOEDgPx7Glc=
Received: from smtp-02-tuk3.valvesoftware.com
 (smtp-02-blv1.valvesoftware.com [208.64.203.182]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-637-5KoDUlM7NYexLNzraLPZVA-1; Mon, 02 Mar 2026 15:53:23 -0500
X-MC-Unique: 5KoDUlM7NYexLNzraLPZVA-1
X-Mimecast-MFC-AGG-ID: 5KoDUlM7NYexLNzraLPZVA_1772484802
Received: from antispam.valve.org ([172.16.1.107])
	by smtp-02-tuk3.valvesoftware.com with esmtp (Exim 4.97)
	(envelope-from <arunr@valvesoftware.com>)
	id 1vxAGX-00000002kig-3oVT;
	Mon, 02 Mar 2026 12:53:21 -0800
Received: from antispam.valve.org (127.0.0.1) id hknsc20171sr; Mon, 2 Mar 2026 12:53:21 -0800 (envelope-from <arunr@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
	by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
	with ESMTP id o202603022053210081302-5; Mon, 02 Mar 2026 12:53:21 -0800
Received: from localhost (172.18.17.18) by mail2.valvemail.org (172.16.144.23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 12:53:21 -0800
Date: Mon, 2 Mar 2026 12:53:21 -0800
Message-ID: <DGSLF8NH5JAV.59WNEOEXYHV@valvesoftware.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Cryolitia PukNgae <cryolitia@uniontech.com>, Arun Raghavan
	<arunr@valvesoftware.com>, <linux-sound@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Icenowy Zheng"
	<uwu@icenowy.me>, <stable@vger.kernel.org>
Subject: Re: [External Mail] [PATCH v2 1/8] Revert "ALSA: usb: Increase
 volume range that triggers a warning"
From: Arun Raghavan <arunr@valvesoftware.com>
To: Rong Zhang <i@rong.moe>, Jaroslav Kysela <perex@perex.cz>, "Takashi Iwai"
	<tiwai@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20260302185900.427415-1-i@rong.moe>
 <20260302185900.427415-2-i@rong.moe>
In-Reply-To: <20260302185900.427415-2-i@rong.moe>
X-ClientProxiedBy: mail2.valvemail.org (172.16.144.23) To mail2.valvemail.org
 (172.16.144.23)
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260226225627; ds20230628172248;
	di20260302185333; ri20160318003319; fs20260302184959
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: arunr@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202603022053210081302
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ksrd3a62vafWSctSFXiWG7A8pJw7TF0pF6uMSqkXj3A_1772484802
X-Mimecast-Originator: valvesoftware.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E7E3F1E5527
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[valvesoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valvesoftware.com:s=mc20150811];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valvesoftware.com:dkim,valvesoftware.com:email,valvesoftware.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rong.moe:email];
	TAGGED_FROM(0.00)[bounces-222721-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[valvesoftware.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arunr@valvesoftware.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Mon Mar 2, 2026 at 10:58 AM PST, Rong Zhang wrote:
> UAC uses 2 bytes to store volume values, so the maximum volume range is
> 0xFFFF (65535, val =3D -32768/32767/1).
>
> The reverted commit bumpped the range of triggering the warning to >
> 65535, effectively making the range check a no-op. It didn't fix
> anything but covered any potential problems and deviated from the
> original intention of the range check.
>
> This reverts commit 6b971191fcfc9e3c2c0143eea22534f1f48dbb62.
>
> Fixes: 6b971191fcfc ("ALSA: usb: Increase volume range that triggers a wa=
rning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Zhang <i@rong.moe>

Thanks for catching and fixing this.

Acked-by: Arun Raghavan <arunr@valvesoftware.com>


