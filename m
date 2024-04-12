Return-Path: <stable+bounces-39324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066208A357E
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 20:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0081F23173
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED814EC49;
	Fri, 12 Apr 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFS6Zgkd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8114D44F
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945984; cv=none; b=UTTemfEMyRetTGbCXM46tDZPlAzSUf3XWnivbRwHsru9kLdwQ8suaWBoJenjEf/MZkT1QwzqMr38ThxFZCCoXUUYoPCKCMYha7yZq2GshX0sl8BSLTJ/PYpeYo+w4DVdV8s4Dai/f9I3+qcvl8twC85t27DEIgAv7gg9eCi9QiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945984; c=relaxed/simple;
	bh=htOei2c/bWw192P66agd0ti+2+jAz/kAsZEcc2Cvr5A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rXQ6e5WOLNbdU002Jxa47L5G05+PPOV0GlP0xpSc/OXZP0XS/foXl7qUsVR04pEirt85HxcKtwsiw+0fDW3PyUqL2cSiMpbId47P/nT8GJ1txVHkvnx7ERT7iJWqz6FP6ML6I0asvelgL4bqM3qy1L+neJFpkNaFrwCJgS2CBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFS6Zgkd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so1240068276.0
        for <stable@vger.kernel.org>; Fri, 12 Apr 2024 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945981; x=1713550781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HKiMe5m6t2daYKc/6UKMwBTZjKtj6RPORQeGE/0xhE=;
        b=QFS6ZgkdBGGCucXzx7NegRYfSCapYtpxcji0vCZ3AssrZomlL2jxmVm+9p/m9hkweE
         EPZGCDRrahB2od5jtFP+CU0doqo8xvK8BFMv6vv1oaFlz6dgtzE1ToIixl6J9bZpt1DE
         ZnH+tSpEsN2Rr/IOHi54DzDxio6UmIWV3W+VABKujnm/bFXeDC3ljNYHgv20q/eQLIDT
         QDgKrAhZ+q1FbcEodNgYnfm/mGCo0+FFuCExvdTfvUBIuvRQ8fVExdd8oc1XUbYKnD9k
         9O9+sNOLHmmt4HfCPKGCDsImA/A1sHPQzzJJvp9AUIB3/Kcredhf0g90IQaSh6KHRLhy
         2PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945981; x=1713550781;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HKiMe5m6t2daYKc/6UKMwBTZjKtj6RPORQeGE/0xhE=;
        b=UDAoJi0WojLsHld90+rLqqpXwQwZLrEzGNMaC/5jDNc3TsulDo+yuiLZA9QyA05D9g
         VhAYrfSvs4Di+LUNrlAEmUTtPltFJYbNPKGI/veyGnKVikVBoanMM56pyNzabB/CIpRv
         i6lXyq2AGt4E4sfnqsTZDn5f/rqIeJ8ccOi+uXjbOQe9u8adKkd5ORQZowDJmlBWNOoK
         iNSrVDoc8i0jtyQEnfqhhd8jhnJBe6kD/i/fZCP6hM9KuCb3aB29B3CvqX/8ZBV3cTSG
         xFdM3gRmJu0wBadW5RWr1dg6nW2RMPYbheBzzCRk8LujWj2nm4XSyBsBdTHbL3XtFWLZ
         X84Q==
X-Gm-Message-State: AOJu0YxRP0psfgRMY7ox1E6HiHfNHAOtxhwDOTN2LKF6I93kRl0CVHOh
	FTvo5LOvu+j20sq8xEpmWHxlTmBsPLyKnQB0MF/yknN9x21QcTlw7n46Tq/pDIANgYXd9Ge1493
	SeKWu1LI+sX16M+laAULLTob8HF6aUBBIQiQ=
X-Google-Smtp-Source: AGHT+IHxQFr6UovPrVB6wRHpgnmcNuNA5/KqGhLIpLMKl3mUAZnLEup08OIwh1A1bvL3CHOCesKCpumbfGY2nfiQ7G8=
X-Received: by 2002:a25:8a86:0:b0:dcc:6d85:586a with SMTP id
 h6-20020a258a86000000b00dcc6d85586amr3453124ybl.49.1712945981253; Fri, 12 Apr
 2024 11:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mario Limonciello <superm1@gmail.com>
Date: Fri, 12 Apr 2024 13:19:30 -0500
Message-ID: <CA+EcB1OKkBSj-VoJpyAgTxPEuj9EOBz-B6Li6fcByYjME7QxDQ@mail.gmail.com>
Subject: S4 fix for Phoenix laptops
To: stable@vger.kernel.org
Cc: David Markey <david@dmarkey.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This fix was sent out for fixing S4 under stress on some Phoenix laptops.

31729e8c21ec ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")

David Markey confirmed[1] it helps Framework 13 under S4 stress
testing.  Can you please bring it to 6.1.y and later?

[1] https://community.frame.work/t/responded-arch-hibernation-woes-on-amd-13/45474/38

Thanks

