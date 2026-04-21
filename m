Return-Path: <stable+bounces-240232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJFYGm/S52k4BAIAu9opvQ
	(envelope-from <stable+bounces-240232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:39:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0D43F07D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FF01305ACA1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C893DCDA3;
	Tue, 21 Apr 2026 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgXCXZYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CC3D9DDA
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800130; cv=none; b=oGOFXpKjHOA9S3sz+c4HdDs/4hCgpt6nrazgL3rm8i1iYx2ApcasChltKDuvTOOYbRTDsWfpN4jme16exQNbCFnI6Zp3lC5CcOQ/YM6kFmvSvyaInJwqbeqa2NuBYsvnqC0pJXQ3nHTzdCrKtJNbYu1huHs9jWAs7jgV3BXVihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800130; c=relaxed/simple;
	bh=ze1NjMvenVo0wiUNIk22Td81LHPfr699YVBOGRCfXQE=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=A/54h+sloaSZahDEd7hNXPW3q5rHWvT2mofgIYMaiBzr2Y5i9Dnyjj3T12ggNu1aZTrkoi4jqZiwCPt3Q9/zF1UhuhQzG1YFNTsZ9cl7fwLaV238WGqDvNMKGU0ZhGJC1xqkL7U8GwAiZgrMgiZ+/HpPPhYq6iCgql07bqrHbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgXCXZYp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso47487705e9.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800128; x=1777404928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze1NjMvenVo0wiUNIk22Td81LHPfr699YVBOGRCfXQE=;
        b=qgXCXZYpzmsvsCCwBr3yByoXd2f0xTvYwvI8j9zpPnHlnNLlOldVQoFklBNv0fX5M/
         LChIvAHr0J4+74QhR+sLl20J+T0zibp1zPd9N5ZOOPsvdmryc3zPaX3sFhJWjFu8ux5f
         BDy4mbREPfaxvrtbIc8GwxNGyIFhEh4yG63nO9v471UWbIxXtUnCrEj52W+GU3OXJuv2
         xcxpndBs1j9f95m1yVGAyyNTFGl6h34Kg2jaDrVAI0VxJKVXlGh796KqIG2ZD9581Vyr
         UW8PKHNr24ScdjVjlNuyvGmw1fnGBQOSpAMM/W/vkO/aOu6LeR8OXJ4Gsze/B7ZTXKAA
         9QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800128; x=1777404928;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze1NjMvenVo0wiUNIk22Td81LHPfr699YVBOGRCfXQE=;
        b=hi4Lyj9egiZTF4L+TQzBS4wnQxE54yt0piy9io7jrGJwtgWnneIlr4uNHghpyyzFJb
         7ZU292QbCLeB7Flb1+0g3d5h4RJxeF7CsamsggRWOlBMFYKHVSJV99GlUUOIAW+lS65A
         rlErYn5+Lp4/6gH1NkFFsBhDD9EU0GKkrru4d1iWFiB+V11uDFOY16SDceepPUq+stAc
         81JStOOa156uyBVQ0GFkJZ0xZI+XJktxp55niAgFY/sNPw9KdStUr4933J3AbRjMAeBJ
         dnq2BoI0lWLchhL9ZtRTMmBBAc2f6KUp8hmxbyWFDg7E2nUnYQWnPR3AS+ZP0o+aeyyj
         az9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9k6LmfXA9bcFeorZwQGw9DsRt2GStWru0ICiNj/dNyECIu2UKT0zsJKER8QMVXQ5qgJPWsPsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAtkfMDeNVfaeR0GRXZIhdkUs2yr52cD63S7IuHfqt5C+3S9l
	NsuEJsJmBqBJqCiQIBuqwTEYYUfB3C7AIzT77bwCxFGOdUDvaXc1V4FQ
X-Gm-Gg: AeBDieuvpDrkayc4mq2JIMZaqmGLJ44K6ZEqqTFuFlYCwOtWy/7H1DFd+3XO9RXRDn1
	ELTgzZI+A6+qUlVY4ruJ2wDV7IKsd3U+oOmkbTzRaX7rQdmI3kJRgz3xHi4DJIrtnCrl19aZtmF
	3/FVDTODE+WqYVDCQl1MysV/jTO9okHVexdBqWekTnMPlZh0o/VNW7winHv1azwh+DwlA/xpOOI
	jJ0ksTs6HJ8ba6rJ4Nlc/35i+2TAmUrPdh6ibveSK3dXh/bhGpQgqnAVePFD+QRQppU97kInjpN
	cqPM+VN4HKLpQcsoSV1aWXMKP0xTKmZ0el8GuQm33Y/N2Y6UErfyhtP/DvQKeLlTg1WqGYh4Bab
	xkhbUMV866olEJgr445VB1rkeMmbAebq8lDU1RKLYl++Ljx8jYcaD1g4a/AU7VsXIcAceD2uzJU
	iXFTMiOwbaiG8Uw4Rvo9m+B3vShMzPgvxD0Bgfidxk4T/fxQU=
X-Received: by 2002:a05:600c:4ec8:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488fb755caamr293169705e9.13.1776800127824;
        Tue, 21 Apr 2026 12:35:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:23ee:1cd8:1171:2646:73c1:cff8:b7c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm357665345e9.5.2026.04.21.12.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 12:35:27 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:35:27 +0100
From: Josh Law <joshlaw48@gmail.com>
To: gregkh@linuxfoundation.org
CC: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
Message-ID: <9F457CBC-139D-4736-A9BB-7B2CD80CDBBA@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-240232-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshlaw48@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DDB0D43F07D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All good, tested on qemu X86_32 (and 64) vms

Tested-by: Josh Law <joshlaw48@gmail.com>

