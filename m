Return-Path: <stable+bounces-267860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QjWEKzwXOmox1QcAu9opvQ
	(envelope-from <stable+bounces-267860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:18:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CA6B4221
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:18:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GBDbwnDB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267860-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267860-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C5CD301FFF2
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 05:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A830D3E7;
	Tue, 23 Jun 2026 05:18:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8013502A5
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:18:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191929; cv=none; b=CTbREXrsQ3bxPxTrInJEfQ/NXdSKTORb2Sqv2oU6OeLNItTTgts+zEJhzScZ31XdJUEkC6tk61fboJlGTtjeOAY83XIcARcfTi/SCKsGdwYISrcgLU47VViCC6uQHsZ8L+JlBWGTm36WpP3trMowHUppXv3LbJXK6Uz8pYEQXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191929; c=relaxed/simple;
	bh=KfJOqsyfmXXIKvwAP834CJTfx23DKu9FvGemclQrN5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJQnpWIWFjhIgvtm2MY2fQgAOROQmXaVf222RCm/Nq+67iEPxpD4YcvwN6SdMSVWnzi9WIjc8LdVqAJYboagN6c40oZnrIRPvINo9ILixI1nGvzQvT+OTXsilKVLLTVBcrdrCp0A+bkivlJAE10PDIFGzz2H8A9XAAeXnVPS6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBDbwnDB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2531F00A3F
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191927;
	bh=yhohV7YjvElsAzT2mfcS1W0N3pAPOcaR2oSGtusTcHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GBDbwnDBHTMRsgfQcWbxfWUQp7YgKqTISPM1yJYJblNm99oM8l8DhzBe+XW+hoK3D
	 ouC1pGqYPQcfVeeaafZrLKsFDwUZBj/3tvgp594WWTCUy+TfLbCOb3zhKP3jFSTjLi
	 W66d2m3DDKC1W3izsDRlalzJmtaVTHH/8cEwItkm+0Q7RbQqaC27kCbLO5SIyxTAwC
	 dbRUVNavNfl1Oul90k7f13cFJgfI5DsZWA5ys+WMshli+KsQnSnlaz0UljkgYuTc+p
	 Q0JrLZiGOz/KKztMNc1nxSVgxXXRENTACA5LUqYotMDxzmQQACYcoNkjViXmQkbGZ6
	 DMX3Mq2JONoUg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c07ea058c1aso827166866b.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97G493jvUS06HMvYfrQlcxCW0HlFr8E1AJiO20/N+2SR2o/8yqnOWQ5mp7JzpOEk4ZBYWwhjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEepFAIB4D4yeSvQ+AlmnaNolQ4glvJkKmiqRoFpbI9+SBh5Ii
	lWita6oXblUizNjq2NDtpQw4QWVGwaIGCQDZgzk57LGsEgJzgeetqj5rv6NT1NWkwkFgAT20cf5
	VfsFwVZAZgj35enECAOFnGLTawCgpa+w=
X-Received: by 2002:a17:907:c708:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c10903d460amr43020866b.53.1782191926362; Mon, 22 Jun 2026
 22:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_61D9C47692BD8C4063364E24FD8181DE1007@qq.com>
In-Reply-To: <tencent_61D9C47692BD8C4063364E24FD8181DE1007@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 23 Jun 2026 14:18:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ONFMMtCMt49pWTobGr9_OS3E06zzMJ90T7Xz0iud6Aw@mail.gmail.com>
X-Gm-Features: AVVi8Ccnzb0xyL_wYj8gawXqJZ6E0dSq_Wtlr-6nG5iY59gDQOJGiQeUUcLGv2o
Message-ID: <CAKYAXd8ONFMMtCMt49pWTobGr9_OS3E06zzMJ90T7Xz0iud6Aw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: validate NTLMv2 response before updating session key
To: Haofeng Li <920484857@qq.com>
Cc: smfrench@gmail.com, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org, 
	chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org, 
	Haofeng Li <13266079573@163.com>, Haofeng Li <lihaofeng@kylinos.cn>, stable@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267860-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:920484857@qq.com,m:smfrench@gmail.com,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:senozhatsky@chromium.org,m:dhowells@redhat.com,m:metze@samba.org,m:chenxiaosong@chenxiaosong.com,m:linux-cifs@vger.kernel.org,m:13266079573@163.com,m:lihaofeng@kylinos.cn,m:stable@vger.kernel.org,m:chenxiaosong@kylinos.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FREEMAIL_CC(0.00)[gmail.com,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,samba.org,chenxiaosong.com,vger.kernel.org,163.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 920CA6B4221

On Tue, Jun 23, 2026 at 10:31=E2=80=AFAM Haofeng Li <920484857@qq.com> wrot=
e:
>
> From: Haofeng Li <lihaofeng@kylinos.cn>
>
> ksmbd_auth_ntlmv2() derives the NTLMv2 session key into
> sess->sess_key before it verifies the NTLMv2 response.
> ksmbd_decode_ntlmssp_auth_blob() then continues into KEY_XCH even
> when ksmbd_auth_ntlmv2() failed.
>
> With SMB3 multichannel binding, the failed authentication operates on
> an existing session and the session setup error path does not expire
> binding sessions. A client can send a binding session setup with a
> bad NT proof and KEY_XCH and still modify sess->sess_key before
> STATUS_LOGON_FAILURE is returned.
>
> Relevant path:
>
>   smb2_sess_setup()
>     -> conn->binding =3D true
>     -> ntlm_authenticate()
>        -> session_user()
>        -> ksmbd_decode_ntlmssp_auth_blob()
>           -> ksmbd_auth_ntlmv2()
>              -> calc_ntlmv2_hash()
>              -> hmac_md5_usingrawkey(..., sess->sess_key)
>              -> crypto_memneq() returns mismatch
>           -> KEY_XCH arc4_crypt(..., sess->sess_key, ...)
>     -> out_err without expiring the binding session
>
> Derive the base session key into a local buffer and copy it to
> sess->sess_key only after the proof matches. Return immediately on
> authentication failure so KEY_XCH is only processed after successful
> authentication.
>
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Fixes: f9929ef6a2a5 ("ksmbd: add support for key exchange")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Applied it to #ksmbd-for-next-next.
Thanks!

