Return-Path: <stable+bounces-45497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D98CACF8
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE04D2856C8
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28C7442F;
	Tue, 21 May 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFFOtlPk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907857318
	for <stable@vger.kernel.org>; Tue, 21 May 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289122; cv=none; b=jNXWXlOfzt+FU7nhACmS1UIcRBNLxChLhD+1EycvYPITmAMfhxIAMmnlzId1W1svgVeYUvp4MIn99UfYB3hl6q6HkJdClEIGZEGruSEqN59wSXrq0/cl07K6xJnxB7w/QtiV5Tb8V3hBLIkpN2gxLUedKFUi9liuDPL/8ncyF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289122; c=relaxed/simple;
	bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p0j4GUKP7smf8teu580UlNvJNIUS7TYKuYQk6GZdqZnrERFBUUvKlF+pBzl2hi1qbxPXtlWF9TEPuh65rL6sqxNhn0j8mbZy9g2AASeR8y2miCLg+WyQ8Mu/uXCamYMYxd2RACF9CgmgsSVcZ5HMNJMYr03fWNt5wCY78wgnX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFFOtlPk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f2fbeba118so23663075ad.1
        for <stable@vger.kernel.org>; Tue, 21 May 2024 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716289121; x=1716893921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
        b=BFFOtlPka/ZalZljwEVQ4fuUwrGQlCLcLkbQ1ztNNW5ktSsmFeYWhxOqkVqVdMp3TL
         g0gQLP1FTmgCHMKGNewDmYnmhNPAwty/CFQX0rUVVPr8gnCVfXF3dWLom3d+GLSzxxQi
         5OC8tZmZx99Cy9Cw7qnUBHvotMRjvIO0TbiM2q/37Z1518NPK2OD0jlfF2q1LhKB9kRQ
         M0DfpB1nreRZGjgduzd4qv1op0XOFBQ4WCjLh8uRNQMTK23M1BP7gqcff3ai/RGyBXyH
         Z76GqkiKrmo7VMkXFsGX7qCb9+Dgd31uGG1gV+NhtTf1R+PbGsfftchD6Ucyq14ar+bz
         hu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716289121; x=1716893921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sS48oj6BasXkTAC+VORQUeUmUJ9WMY8uBT1xpUEniDQ=;
        b=fN3TZ8yXx7RKwyp6pAqObplBn+OlSMtgZ/gulXSNJQAQK72eUk893KbaCJaMHFUMy7
         uTuaRTGMmOmL8U56VhASEh5K06hortAMxh1DfJoVhsiCzPgO1Edpo3xAYRbU6fg5S5Ns
         T2F0WSLl32jHch0ZeaoX3NEfyeHp9/ce66McfBvx0lbpiL9jkw8i/gqoGolMS9pXtn3k
         ke7eTBE0008ZtIsQSp0aGCwkEkwaKGs0Q+mcrUKd4X17XDZeNzbidXmyPl++afl1KlAg
         qDyPqbnJ01fn71MPZGWhKpfkoILSIZTwyfkbJo2l7ST/kNrxEqXZeys1x7CKU4M7hc6+
         ZfQw==
X-Forwarded-Encrypted: i=1; AJvYcCUEBVuXdUAWDx9z8ql60MK2d4VH+DftZqNXwwaU0Mm6PZcvsKenBiSu2gdBTwCHNB2gpgic2Figy7QdPUAF8ZiL0d26TDmq
X-Gm-Message-State: AOJu0YyWw3PO4y4P/QGk9zexyme9/w68sFnQjYqiRpIH3SGx6F67sV/T
	PR2RSjsFeVR3jqgKR1Vi40MQ/LNzrden8u1lD4ngmuX/Z7dwaFrPxnT3RhscohJiFQ==
X-Google-Smtp-Source: AGHT+IHfcccLfgGAx8DfFzDXNJWCMb6UCPSobMN7oe+/U2JU6yVXqC9FHuCvFA1pp8A8C36jeXJPBF4=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a17:902:e890:b0:1f3:97f:8f0d with SMTP id
 d9443c01a7336-1f3097f9164mr3054625ad.4.1716289120763; Tue, 21 May 2024
 03:58:40 -0700 (PDT)
Date: Tue, 21 May 2024 10:58:38 +0000
In-Reply-To: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240521105838.2239567-1-ovt@google.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
From: Oleksandr Tymoshenko <ovt@google.com>
To: srish.srinivasan@broadcom.com
Cc: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, borisp@nvidia.com, 
	davejwatson@fb.com, davem@davemloft.net, edumazet@google.com, 
	gregkh@linuxfoundation.org, horms@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, sashal@kernel.org, 
	sd@queasysnail.net, stable@vger.kernel.org, vakul.garg@nxp.com, 
	vasavi.sirnapalli@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Hello,

As far as I understand this issue also affects kernel 5.15. Are there any plans
to backport it to 5.15?

Thank you

