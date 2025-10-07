Return-Path: <stable+bounces-183501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B0BC007B
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C3F189A446
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6A16E863;
	Tue,  7 Oct 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xKJHbkZy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FA1B4247
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804220; cv=none; b=Nk2IWIuZhF+cGEgTIqAMp4vy8YsHZrIY0AZNMQN2JuCnfUNb6eFMy3Sez7aJhraKqeXQ9VJOPZpwPaE7rrxy2R/mDdm2JeM7c97c16XhUI5U4w+YNu2GYsyTWkWFDQzX2+YwjinLKfRUeHJXa/YNy6z3Ru5E3OaMFXZNOt4WSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804220; c=relaxed/simple;
	bh=uJlf4OaNoxaJnhUpN1cv8CptXSZVlmbMKWjHhh7KbgA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=uAZ9a/histtOY2Ftr9tfGV36oFtncWwXDGJb010Rn/Uy9oBrClwlIzT0TZl1ZvVEOIvBF27HqHCsZd/m6x3aik2tC+hFd0IwH/QnEHnGHPY1GqLQOCpD0N6gmaOZLHPVWFXkqKyjp9Fgbx484BRqvbb5BIpstHKiXQ+bfKs7P3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xKJHbkZy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78a9793aa09so6680187b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1759804218; x=1760409018; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxwrlAFbGl/q8Y5TVQ9cfyG3etW3pffyQuTrGZcrQ+8=;
        b=xKJHbkZyr5XEceY+fHzzac2djRLBq249h0iHMLbfWBD0eMpwq40yU8xdrX8HP8P0Vu
         dBgnx7n93n5HTOLXTZISVKzsX2ydNCHx6ebKfOgvgreKSNU7m5K2gjq1pG2LMtpKwm3y
         +9LiV7kj7W6UbPrlhUlTFpzDM8RvL9Dc8CXSd24KRvCT2RIPcOmM/GhhO3zTkf/P7R8b
         +ZyKgxeon7Hc3+b20y0/cN0ohU5Fz/JTTnojDg+iCv8YbZZWpyzP43ugFJlByXH2HnuG
         ifMtrT8wWWOKr16PocOmgt07mFsWVLYYrofKVrUCC3Tf5XYjCl+yPrYVxYuDdPI1R5V7
         9mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759804218; x=1760409018;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sxwrlAFbGl/q8Y5TVQ9cfyG3etW3pffyQuTrGZcrQ+8=;
        b=FaGaEhubEEXBwV+KXBYgLJni5kcOKhDSUG/S/3f6S6b1nxpgJQRvpgSrm8MPVLCbUa
         E5NbQy/J45d5uVV2jjgfCRY5JDIuqvF3jTQ5szlIx80ZmSF+AAMGt0NEWDQTbNO8FEdY
         zmg9c5rfv+pbZFiK3SBLQvZfxW2xSFHaKJsisxTo/eAVMFyhbupE+P+E5ctImev+rz49
         S9NH1P5nYUam7kJ2Ewoe9iLG2eV7XhoqQlwHrYH8n7JYoQ18aeEeSwrNp3eHG5Psy0qe
         u2Ebk/vMaGwTYVKNjtffzO6Z9gvCsDoQDiZkuS9+rSkWXDwInW9vOTzsaCQ1yfibpUuV
         gWcg==
X-Gm-Message-State: AOJu0YyiIMVZ23l/HHnqsTsV9lnlNR5LNABcjmQRrDTZUqbbvwvf9mjx
	ZoJd8osLhZAf61Vo0hKqKk+++bShj01mVtEWyNJ3j4FqJOVAPXAX8j0nWtFuTnIB0xsJFtdb+AS
	y0YJi
X-Gm-Gg: ASbGncsQ5L3GMkuWXWb+bEUvQvB8MLgmbhP9Unn7Opb4LVD/jmsjfbqYP3TgoWRIfGw
	e/4CcGcopHpFeoroWsDd35mza12THY9cCrNt6guOZmg3ol673LaYq/xj5OtzpAmqzsAFXGUh5lY
	lVnhxO/khkopWoyDldVgtDK3P5vPy5lEYpLrpN2zTN5yeV6K6UfOQd1S8ozIiHRUPN/3MKXmkED
	B9oTCuPWd8eSRTV3zoh/rVywUP1dz90TpV43n12DT3xS81x8Jtb3CY2a3o9oDpw5nrh6Jb0juEo
	d/Koxb3F9xL8sXvUwklzU/CX9rXFDyLva9uw/3bORmZV/88AERiyBxX8W16GOJ9YHuOaHMBUqZd
	ZUS//WXz7IFcJK5Q5goDtX3apBCmB3M6W/HA19KAY
X-Google-Smtp-Source: AGHT+IF31tX8YQRCLyfb1d/uy7CPMLdI7bc1a3sQdIpFtRpsU5uO6Z7O58jUG7G5tnGyhmsMjsWhaQ==
X-Received: by 2002:a17:90b:3a88:b0:335:2a21:69db with SMTP id 98e67ed59e1d1-339c273dabfmr21366838a91.10.1759804218387;
        Mon, 06 Oct 2025 19:30:18 -0700 (PDT)
Received: from d76c3c94e839 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a31975sm12593979a91.13.2025.10.06.19.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:30:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 a9152eb181adaac576e8ac1ab79989881e0f301b
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 07 Oct 2025 02:30:17 -0000
Message-ID: <175980421727.60.18054395891363421649@d76c3c94e839>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/a9152eb181adaac576e8ac1ab79989881e0f301b/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: a9152eb181adaac576e8ac1ab79989881e0f301b
origin: maestro
test start time: 2025-10-06 09:30:07.031000+00:00

Builds:	   44 ✅    1 ❌    0 ⚠️
Boots: 	  172 ✅    4 ❌    5 ⚠️
Tests: 	10782 ✅  945 ❌ 2510 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx6q-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-12
      - kselftest.dt
      last run: https://d.kernelci.org/test/maestro:68e399ac9512ca5274538de3
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

