Return-Path: <stable+bounces-223791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDOxDl/Zr2kkdAIAu9opvQ
	(envelope-from <stable+bounces-223791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:42:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DBC247747
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 089C13087D23
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D002C029C;
	Tue, 10 Mar 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pozq2Wei"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FE26461F
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132118; cv=pass; b=q4rFSswMu24uS+P8ZqPCHXnGNT8TXll65nW61yS2XXJPrtNvnHPBHqfBuKlz63D5KfosAersmcv/OOQrYg5gBP0k8I49+p9VC9b303Fv8t/OL+oCaiJjNuiurZW/6pSoA3sX3BpajKMTTczwjdB7GTKbN7LLsQpQ1+acuGA4gpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132118; c=relaxed/simple;
	bh=eDSWPCbwxBzo4De/D6dtfMarcGEIAzAKbz8L29S2nKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADGAhSaZE3/+hdo7j+0M561rfqH3PbOCDbPo2kF9ys2AFz7vLd6TPPUGLxuZ+Y9ZxmGC8+1WKPt9Qr2KnOhgCUEVbOvdxmzWMIZwwA/F9TOAZrkmgukT5XFfQZtD+LmytI/WkBiqi75+s1spKydEKTMH6m7Fh4EjSv657O1s8sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pozq2Wei; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b943a880577so433993766b.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132115; cv=none;
        d=google.com; s=arc-20240605;
        b=lHdxghkMWflN391A8+hu7Hp3lvmQTvChvBgz41AdWtdCVTcZnjUZ0Bi3wYVumatevc
         FlWfLnBaatrJh3PEYfmT9lc2ALfqPNuPHpxRUyTfcGHqu93uIhf870QvzzwiWoF5gqPV
         1scwHSH6MJNFsxb9KMtm4Wnk/YmukXPHndqMYlB0yuAj7NTu0xzZfROmrpcmscAmRwH+
         urAYJlWmWcQSU4jlm9CJpMfaS0BbK+yIFA/NtCgWJaG7dv7Spioon/Ffag69JA4+ip3O
         5JESSCL1QPeiAfZBjre6DwjlrN1PPMBVEOscamTmOgpmhe77ZLq6nH91Y2dib1hsXdRK
         dX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tcHneVAopfvC6QrBV1mtbNtLaENsIGFUlG2qWEyDgec=;
        fh=S9IEOntFLNV/vpgEDWjrDNoXhclHz2QSuqmWMOvcnus=;
        b=bPT/d45aNKJLRPBgi8scc4UV1XiY4rtyCMDYxZ0fP/7y2eJeV0F75tuDq56h5uY7u+
         890j0nZJc/Egq5cLW8SLk0bpkhZfehjg1/3n+sUk3IKXaLBYZJUBXNwf/iMWR62jlp3a
         uuhmivEO/UoSB6ZdoHBrI2UHFIliNlCmIO8dr4rahv521nx9LZBh91nPju3lAnmHT5TL
         c0jm2SDrF8Sz0WtN20S10cNc59sb8/VM3rzmSKMCOmsetUqVnSiR6mWCwzYAXQI5pKY2
         alLfOtSHbGr8cKsd4SIl0TT5XuKMtHkyUnIw5MaN1tVAWLk4lYyNsS1N6er7cNaZYQ6g
         CSlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132115; x=1773736915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcHneVAopfvC6QrBV1mtbNtLaENsIGFUlG2qWEyDgec=;
        b=Pozq2WeiKfChyXk3ex92JwbqnxDHNpHr1yfu6eNn3cz2TssemkyL3XxjZ8GHdu9Dkt
         gO5mlQJmb6nptT/oTXCsMtQZ0CZup7tVndaMQiIp7ZNby5eiD3wNQI9n5S1OrR1p2k3e
         qZ1u4wIqgCHZlp5Auy2lNnTmSClhFxuWuJslzD0yVTLoNnvMRGC+CZ9hzYy5D6GLnyJL
         hJPgx/LR3wzgd++bvIVxoHApj+gHGuZcry7icts/Wcu4kfvt2g2pfI2c5W81usFUeYOY
         K89qbA1l98CO+NF3NnDWRqcjreWX4MwYcI6FIXaRbBUjQB5W0my2My3Lq9VXBheoSUMf
         FzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132115; x=1773736915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tcHneVAopfvC6QrBV1mtbNtLaENsIGFUlG2qWEyDgec=;
        b=B4yFE5GXIuXNI2ZtajWY//Fl/RN8SmGQ9TH31fmbiHM/W0YKuXXNtCYQ2QDXA1I7Rk
         3hl+MqaXLdodmmjBO5dTN0DWuKChSU7vqe7wn8vB5/dtx9PJ33NxsDmUDIdzFqueTMIy
         e5GndlLsCaQYel/rfa92mCH0yGk6xhPjW1WqQv1b5AMENhyCi1uEPDxzbwqti+k43VWo
         ZJQz5nzndnPl5oIH7lFROh+6jbykeUVptVkian+nCGUl32SfZdTbcYNPO7uc9RqwD7uW
         ZzdHjkIl5IuAkV61FUZ0gMym9vJ/q6QdKabolmeQiFQkOybbdn+mCP7tfwGLEj06upAW
         1wtw==
X-Forwarded-Encrypted: i=1; AJvYcCUrPQN6yf+8L27qVigmu7hqY4gIHidwNqnO9k23TOYupKGnZmt/2sPHwgn2EQoyl2hSbMpZWWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTtOTEs5oRnvjZMEsyBTLk0fqs0iaNskDlbsWHwbMHHWIXKqc
	cyfzGb/M2Ai1a6Fda/tXsP623EAYQvS3NtFP0pws+jMwUkCwOohi2TBsNvqWLo+WrKyP4aGdfPY
	iwenHnty9LflClgQNBbAM7Ym7Cd5BSZQ=
X-Gm-Gg: ATEYQzzEb9DqaopQs1plMujgO/fekxC/evu47DUV8WB0lbXOL41QN3Kt5AXja81vr5o
	zxpY7rrQItWUptxdIB0O0FKyS5TDkYZrGbieNo3Eg8qoY7gaqJb6IUuv/rQxs/krMClid7PKbiW
	hDH22YemxffSJtCvldL57K3xmXnz9OSoOaXbmZRR7L0MpQR9tHtCCD9cISKF4UZZvkSLP4fAz17
	Rq+UM/RO/F/PK8K1PMVXH4W0IWzT40d0ERUVrEBSfiw158XpN5IbnxUrb473g9lYjN/ERW4MapA
	AA5hd/He66eJvr9KZ8cANCOc6nDQoT80kP354Ir1/RiLOX3EhJWvqyhZ5axzrkHatBcuXYDZwhU
	CnRLpnkVSv45cnDYrKZWedg==
X-Received: by 2002:a17:906:4fc8:b0:b94:25b5:2b52 with SMTP id
 a640c23a62f3a-b942dcde31emr782688966b.27.1773132114793; Tue, 10 Mar 2026
 01:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310075447.2088205-1-gality369@gmail.com> <19e81a86-a8ce-42df-8cf7-da74205584ce@suse.com>
In-Reply-To: <19e81a86-a8ce-42df-8cf7-da74205584ce@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Tue, 10 Mar 2026 16:41:43 +0800
X-Gm-Features: AaiRm52HhZz3j4znZQsuhdkwjJzg2SYK8Z_mFutGffEHv2kfRcHu3qiVx8J_a08
Message-ID: <CAOmEq9Umi=3AA+0DkmHrfFjj2hBnkq4xGSFdfS40x5F7DpEtuw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reloc: unlink orphan reloc roots before dropping them
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B3DBC247747
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223791-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 4:13=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >  [...]
>
> Put this important info into changelog, and this is not the first time I
> or other reviewing asking you to do it.

Thanks a lot for the detailed review and for being patient with my patch
submissions. I'm still learning the kernel patch submission style,
especially how much detail should go into the changelog above the "---" lin=
e
versus what should stay below it.

I think part of my confusion comes from seeing many patches with very conci=
se
changelogs, so I have been trying to keep that part short, but I may
have overdone it and moved too much useful information below the separator.

From your feedback, my understanding is that the changelog should include
the essential root cause, the fix rationale, and the key crash symptom
(for example
a concise KASAN summary), while the material below "---" should be limited =
to
supplementary information such as full reproduction details or longer
logs. Is that
the right interpretation?

If there is a patch or changelog example that you think is a good reference
for this style, I would really appreciate it. I'd like to study it carefull=
y
and improve how I write future submissions.

Thanks again for the guidance.

Thanks,
ZhengYuan Huang

