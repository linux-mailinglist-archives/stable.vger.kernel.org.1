Return-Path: <stable+bounces-25420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8BE86B760
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC325284F58
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7671EAE;
	Wed, 28 Feb 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I8YfUAB4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58C71EA4
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145787; cv=none; b=p7Iclc2Af7bzANMMfFpvnL5CklYPMdwm9YfrbR8UfKC4BG+6YLFZAYduPO3omm6WjUmNy0DPj5HhYR6zKP1vnMbWIPEK5PQFmFML1W6JlEXOHe8LH+lt417hL1RtbzHM11pkKNQVESFllILc8wBz/3PKj4HdQHl0lCbdYrh9eWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145787; c=relaxed/simple;
	bh=sNmGfVcP9hgH7Xy5LglEG3XB4ye+xH7IiV2jB1rdr/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/0Rge9xUgFU3wWYfcqNaFJGZJrI/aMGMjSUzp9o1vJp2RQKAvBLsrZ5JVQ+oMnZdqloZ2vbNicdrqEKwrbHighsV9ta46mu8xD9vDbuYXDfeXW4JDdgylQVKQluUKhy7dlcKwozJJgSH9ROYIYeLE06WuOp3rMEJG0PIHf43cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I8YfUAB4; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1dc418fa351so9170985ad.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709145785; x=1709750585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaNQMKpucs6MhzPdXolyLdtUOs6DJsWnp2x08/1xdk4=;
        b=I8YfUAB4OaWKLiLuDoNvEUC+qaHoqHdDi+efEiiAv4B6fHG9ls/JZ1ctfze+9oK66t
         TtixpmbZUzxjBKRGXjJrCLDnkxNbaTABTqL1r1uTkFWue8SBNhIbrYMHTsc8sc76ppYC
         XNjanGGiyQJkS9D/z2OJ7mRieJELH1NLRqGo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145785; x=1709750585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaNQMKpucs6MhzPdXolyLdtUOs6DJsWnp2x08/1xdk4=;
        b=tk1QncsPj3BHddAhXCWXtHu5UtcT810o3FHti3jmLlVO2iact2OMfqydkLlUfwK6zf
         7B6u7/si6MpEXQDsCcvrAdiGlSVCihmXWbDmyDjFXNt6nFiBpjKhYxh7BB98fm3kk+Yr
         8/lZbowpbwjIzyAIGRY3TY3RkPB8NAj0U08YoxJ1dKbbWHCj9vGK82bb115hpjBjZe2R
         p8AOzc6iXryKfFKptSxFdz/yg76JoKdY4032Jmn3CYKTWkQb1puoI8rHELIzhKOJwKwc
         Dzsn2vcUUL8WraexFaoVGieFV7LLxAzTEMjjwmWHAywtjuyWdhOP0m0kaJt7Y6hkBqOf
         Y5ng==
X-Forwarded-Encrypted: i=1; AJvYcCU1nhxOG/Lj78u4Umqa6RcnmHhjOBswRzuoqyK2ZqfQzDQiZRhT0HGeWCTFdvduSet3HX5998zqQdJDDn5QQpcID6X/C8Nn
X-Gm-Message-State: AOJu0YxdULBujDdhTw3sWGnr2LLKTou29ZBS2zAnI4VDxjOAglU7TmYM
	BoYWi2/VR/+ge60YeobgCTKX2nbvhH+7RYtahwS7pcjHqrtjecTY+xwbC3M//Do1EYyN8a82GQv
	tcJxJ7d0=
X-Google-Smtp-Source: AGHT+IFJTIOqKLw4G/piSneKij92f+jA2+WsDR68mAxC1iGKy/jHJMVkTJ4Pf82RCHHB9aIeEocyDQ==
X-Received: by 2002:a17:902:eccb:b0:1dc:b16c:6406 with SMTP id a11-20020a170902eccb00b001dcb16c6406mr337989plh.6.1709145785299;
        Wed, 28 Feb 2024 10:43:05 -0800 (PST)
Received: from patch-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902aa9000b001dcb18cd22esm3593364plr.141.2024.02.28.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:43:04 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: phaddad@nvidia.com,
	shiraz.saleem@intel.com,
	ajay.kaher@broadcom.com
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
Date: Wed, 28 Feb 2024 10:41:23 -0800
Message-Id: <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024022817-remedial-agonize-2e34@gregkh>
References: <2024022817-remedial-agonize-2e34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you provide a working backport of that commit, we will be glad to
> apply it.  As-is, it does not apply at all, which is why it was never
> added to the 6.1.y tree.

Oh, apologies for requesting if they don't apply. I'd be happy to submit
working backports for these patches, but I am not seeing any issues applying/building
the patches on my machine... Both patches in sequence applied directly and my
local build was successful.

This is the workflow I tested:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
make allyesconfig
make

Please let me know if I've made a mistake with the above commands, or if these patches aren't applicable
for some other reason.

Thanks,
Brennan

