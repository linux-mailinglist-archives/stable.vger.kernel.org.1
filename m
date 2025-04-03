Return-Path: <stable+bounces-128150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F8A7B08C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DEF1897F11
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B72066D8;
	Thu,  3 Apr 2025 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NbW3qdye"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E92066C9
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743713976; cv=none; b=jdCJiacHjXf0VOZcmJAa5HFoRlq7mB0Rno5DyE2FcXHOs7axOySUWKpNpGrX8Vy7R/ozVaHoCoHyf93WU4Uxx3zfJ23dfeaQ9HWwOqYJIIQtyx7xx1dWG5wn5r7c7EGoX6AKlTFvMYxCJIbC7JNqHPoTR+ioKRL9GHvUi52sQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743713976; c=relaxed/simple;
	bh=ahscwOtN8WDZ4+HXJ1W+9JX+DG5VD/Kqi8NR5diKv4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbw7lvyS3px1jcDzzr+o+zz2fiodkSlWeW6KsS/9yaoxwpPjJa4NLD+2jx/tisfvJLt11cw9td8mbQ2twP0nnqDM3FL3YFg2QsagINzqWU9ZDVE9M4Su+f3G+a+w3gtyGLmVVcoxz5wzINoMgGJwK1QPongHdAIBmuNey4nLTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NbW3qdye; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so221519866b.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743713973; x=1744318773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QKfk3ITrqRcQk6CmPZlvcWM3vJtVNrb0pOcfShqTWjE=;
        b=NbW3qdyeOqERFM3ysctYcW5KKIrrPCZSDQWFTrBgLG5AgcKnLV0Uag5BiboipEQ6zp
         u3tZf/0q3eFiTg2NV+kntLRS3l7vXbkMr4jVHlldo1apsoeupWrVq8OrlkRaJgWDkZRn
         1Ak22+vKZY4d3/Qxd/t5gB+59CMprDgLuJVwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743713973; x=1744318773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKfk3ITrqRcQk6CmPZlvcWM3vJtVNrb0pOcfShqTWjE=;
        b=BHxbwINbfSVswJPLaFfwwkeO4jqjh/BpL1uV32QJVvglhAeYAvL67zrDLwmA8/etPu
         aaSG6ER3oZ5UzfDFic2eYLqiVLRkxtYEdxKl8XIByVtvsMmjKDkWN5zfmlIBXfbgvDtF
         pKx+BsYGezABVZiV5UWAezCREudgpxyk9KqrLTIsmZwR0hZma1RjsTotFIt1ZgRzen93
         R+TdcVtWz3e5ZRxJmyhTINzdvHRlusVQgxjQwm5OrE8gaU+/RJ3/KtlpshV/lRJdOkwA
         Trl3Angpaew7nyMSIDTRpdWhMHJR8oeRmnaXu5TZEquMs92cCcSyu0Nji2sgmjM27Aak
         /4pw==
X-Forwarded-Encrypted: i=1; AJvYcCWeMOKQxdJqIW8nK11ZiiPG2CfGsEQbbRvTF4J8rYoMWCugn62eiJgKmjAn00SdPDoODKUsKvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzT4l49zw+RRzdSM4qm4JcwZw/X6gJ7HWVLzJ/kMkRWlKS88mT
	yV9wpNguGfSjg7s18LFkl/Uzu5sc6B7QgoYl98yjsPGnn2K9NXWJJvisrOA5/waV9ISqZhH2388
	ibVHnJC6A2xBrG4kG/qmYQF38eeAMEsq5T8YgqX3NswBShHeFFD921cciqNA05AbZp/pFnPBoZb
	z6S3dOV8romstMRKWsPg==
X-Gm-Gg: ASbGnct4s5yeQzsS3PXLZWxMNH+Y+xyjeHhG9u9cLgzcWTER9QZRtfeqDVDW/pRtSwf
	KNYFJQVDvkonF2zGSjOUwVKy/W5bU1AvzpUt6hgiFxDfg4MA8vM6Vi47JGU2VELXrGXOXgZi3Cw
	Use0UCVomtzZfyNFQMviTjSOOWEhw=
X-Google-Smtp-Source: AGHT+IFh1Oao3C64TeG8/xDtboKmHxFs9G/ZRJEekYKAv4owqcwkmWTokzkkFbgVaBOkNAK0U/qTOfui7AKBGwtvIdM=
X-Received: by 2002:a17:907:7295:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac7d166a7efmr69685266b.8.1743713972960; Thu, 03 Apr 2025
 13:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
 <20250403032915.443616-2-bin.lan.cn@windriver.com> <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
In-Reply-To: <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
From: Justin Tee <justin.tee@broadcom.com>
Date: Thu, 3 Apr 2025 13:58:00 -0700
X-Gm-Features: ATxdqUGSUjTCRLxiXPGa5qchRrOGURenRLQr3KOIjvtyCNKvV8YTPyDUxyVLV_k
Message-ID: <CAAmqgVM--YEC=hNt5H8DVUwvN9G5p=UX86X-VqKQG2wH9Re7+w@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
To: gregkh@linuxfoundation.org
Cc: Justin Tee <justintee8345@gmail.com>, Bin Lan <bin.lan.cn@windriver.com>, 
	stable@vger.kernel.org, bass@buaa.edu.cn, islituo@gmail.com, 
	loberman@redhat.com, martin.petersen@oracle.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f853a20631e60b9d"

--000000000000f853a20631e60b9d
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> There is a configuration dependency issue in the original 5.10.y,
> CONFIG_SCSI_LPFC should rely on CONFIG_IRQ_POLL.
Is it possible to help out by porting this commit "fad0a16130b6 scsi:
lpfc: Add auto select on IRQ_POLL" into stable tree branches 5.9 and
later?

Thanks,
Justin

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000f853a20631e60b9d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
QsyUohclvlxgt5d/MsBG6WZxZ+uppzNvjEk/wUu+6JQNUVEMviA6eBCCi+4ShjZUbGPES11h5lw/
wuyQZDIjy+1hGPtLHBXI/QQEbU3OVdTRn+aEMwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdqdXN0aW4udGVlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUlHfvnuNaLp52RO2Y2En9J+7MKI4wDQYJ
KoZIhvcNAQELBQADggEBAGaBsEmLZwejb3YsmigadLZGto3hJ7Erq2YZLhL7Pgtxft1/j4JNLsRN
t3ZJIW2Xzfbj0p328xRekSP1gjZ9Szre0fxEFXH1sS1a7WP9E0fHxVW07xVsxGxo5opAh5Gf/bQH
S4x9pCO48FJI310L1RGQiqFKY/OECnXO821y8MAyObbGo9HNHP4Sk6F5J1v2qJzbLtMfj8ybbTGe
SidstRgjOIqMldZs2Koio14QFE7hJY+8KRiKfq+eb1EwQTMzBxZsMOL5vUSZjYg2+Fqwyr6YYp0w
Lsq/wH9o18xSvL/FikpG4JRxiT20RdM6DQrk9lv8ijASZCuN3JR61WUNz2AxggJgMIICXAIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMd6BsMSBDsagVFtYwDQYJYIZI
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGUPYvpyXTX+ppiXISt6mF0yxGcTtaZZaTMk2vtb
bWaRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwMzIwNTkz
M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
AMukHM2DHM8AC5TVDaLsctz2gaNbL9pCQ+EMoOAJ4LrBiU6Lx6crHViNv5eS4Wg5WHfRdRCgD9SW
glCnGivdRy1fkCt6cMXIaWCYMdmDtB+4ygEE2vbb+SoUvpfI98WCjKxqOPBwW5AL9fkkYfmSSTNG
7B7vLOEjseJqvB2MoIiPCQCu+1oj42DtfZKk0eKpuObBTgTCydjYSTtdc7X3i0EOI0P9bSEcul00
7DjxTDTPuVkj5KkNKa4l1Z/hTBaUvxNq9MGdu37L2t8AwmEM8s92RhQA4tpcir/1ENukqrBIfnxD
Up5Xdm1mTucX+EdHAxoZcZafa2pnFborJJndYUc=
--000000000000f853a20631e60b9d--

