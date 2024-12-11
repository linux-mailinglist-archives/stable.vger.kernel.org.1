Return-Path: <stable+bounces-100534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D449EC46A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 06:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9981E1889D60
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E786334;
	Wed, 11 Dec 2024 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="SmPjQmnI"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7441BDAB5
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896006; cv=none; b=oYVKHuPEaKfPF60srNu2V4n6eBr64NkYjyVg6bdnWXqqzB1x8icflUi/OU7TEHLFgykGzBGP3pwhd4tBGCCIccUbZ0DjGA7RlGYmFnnBAWPsSVpASGR3NPZmB7x4dHr0WdMwzbFS/YN0lrrlVYNy/WmBAmiQowM7but7vtVz5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896006; c=relaxed/simple;
	bh=vuKBwKKcM1yHKebtODcjdPmF4fl/LodT979mqecwYeI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WTlSKTGiGOn5qEe7b29y3zYBEafgprXLLjQ11xV8SDte7uvcKAyUYU504eBmQg1SreMTpEtk4vbBXQghow5O8ip/SyeMZkFBvR181J+Ro9qpff7rVs0DXPN8UZMrQPIKwwUN/iKL4d14mRQ5BMMbhohuuPy0MrSyy4rpW+ocroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=SmPjQmnI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb7ca55c3bso480792b6e.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 21:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1733896003; x=1734500803; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vuKBwKKcM1yHKebtODcjdPmF4fl/LodT979mqecwYeI=;
        b=SmPjQmnI5d81I86pOsc6hUsCxFPaH2l89XtMPAb2k2/DIhF0FHQIgKtKo3CiTZ4ykV
         nz6sXWAaS1r0dze0LpBNKKn0iAELeKhGCdYUV5OgcK5sLYBq5rIB/Y1FcMjmAvne0tw4
         eRDXnoAUd4QX25KMMMEL3JcjpsAL40rI0Kewg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733896003; x=1734500803;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuKBwKKcM1yHKebtODcjdPmF4fl/LodT979mqecwYeI=;
        b=M9RmB1hsPtFX5+zDOi/oLhYJ342E9qrADeB54oBAlXCsn1/irlxtNKxssWPj6bxuZ4
         NbqE50fvn9jRPppN6VeEfpFWewXYG0ShD0EiPsuqp6Y8bmpBTzE1tGhF0Z/HrsmZUm5Z
         hIMF1USU09DrGdOXHus2Z8zj3iaX1vVQ1vPNKZ66g015yTak3TSlJDfDpjGuzFg0qDPe
         HUvCEuWjRr/Zy4RnuKiW4COZ892yQuzdrNEcxOLxAb/O/J7PtWe/X215NnzeFlXHbGA+
         tAhy0aZA1XWW6mv35iUyQcjUp3ppG1J6qFhZHA9s/q875cL0+212K+Otvf7Ap/TVosj3
         GyZQ==
X-Gm-Message-State: AOJu0YwiGNPvDeT1DqYWyHhS+1f1BwyCEoPxnLQFA1fN98wVQXgHp21h
	sXjT0mPzQzlvTzd6MWCrIMywo5w37TXk4wACStldlg3zyAl4pTe0hP3aQHK4ZCgo2MwfdboVMqB
	osIYvI6tMhOVtLQpP7bBrS6mY3H156aBuSGnU/8+MqgcqYdh8D+Y=
X-Gm-Gg: ASbGncuzd3DLk1uR5vOHN7H2ZhNSjJCaX2tC/+S0PAX3G6TRolgqAp93y27HGQeTMZM
	YnYhsIqhZXfNzWUatalI+C3W8jDjwM+rJSLARUxz8m53sQaaVbQhgHwx6sJ4RBoMG2Dw=
X-Google-Smtp-Source: AGHT+IHSOgjqXNLpcb+1xaeRJUURsXNP+9Vfz6YD451WqVRAvkCIoGCK2Ls5Y4QAQx8MJKg+Zd4VnHMlkz6T6cStajQ=
X-Received: by 2002:a05:6808:2226:b0:3e7:a1f5:781b with SMTP id
 5614622812f47-3eb85b4be15mr1028912b6e.5.1733896003586; Tue, 10 Dec 2024
 21:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hardik Gohil <hgohil@mvista.com>
Date: Wed, 11 Dec 2024 11:16:32 +0530
Message-ID: <CAH+zgeEVr3g23gtcbHtQnUpC5R2uDZ3T56wzx3g9cNnvOZ-+HA@mail.gmail.com>
Subject: request to backport this patch to v6.6 stable tree
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ethtool: fail closed if we can't get max channel used in indirection tables

[ Upstream commit 2899d58462ba868287d6ff3acad3675e7adf934f ]

