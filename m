Return-Path: <stable+bounces-133328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44FA9255D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF847B47E2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67D2586F6;
	Thu, 17 Apr 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="o0tb1R2C"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5782566F2
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912749; cv=none; b=YQkV3zqo7XwXvzRi/Zb0vFvmKUE9oxoT0Z4fQw5kOT+uQ/kj2nsfq1JOU00aWu6YzI3QEHTvS/F9bhFrmpUxNO39f+KLV1BYJxcmpnLG/Xkf0KrQUWap1iAkMBcdUS+0AZj8ZF/0kpaxFUlDWGzUjy3x/eQ7kAkUPSWFwsqYTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912749; c=relaxed/simple;
	bh=XZ23HX1Idvs3DGEw2pKUbBL1nkwPjMa9AHUbWoDOP7s=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=BF7QVXAOuXn65hK2bGeXcrpUJLZptCDCjBOVR46c6CnhPLYbJHVZMrJjzSezx634/WhOXqrww0XC6B9Es0ApmyM7bBm79Or7tqZ7y/bbEUSHUYJY7kqdY57h87Be9K482MXmr7hAEDVWDmSWddd7ULLexNU8BsO4mU4U3ai8C0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=o0tb1R2C; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7042ac0f4d6so10495467b3.1
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744912747; x=1745517547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbEaFqrqcUxdjS3XqjhcgfcBPZB6s63BuuIBYQhCU2Y=;
        b=o0tb1R2Ct9BFzF8SrUDvRf8bauUgkQDbmGp72AsDgdM4s0XrGZ0X+O47nYMlyiWF1l
         eS8MQBBzfS9W4mchFmesw11nELG5LQ2wINCeSrBOfgOGZcutwFVJ42GImaRPIMjfilTC
         tQcOpcd2sb/PlguwnTN32iXrhMnPTSChfl2CfxJ/tj8ALU8GGkOrfbE7IrPJzhw+njWu
         J91ITzJ7mDiVxyd1fLAaQ3va3ziBOAvrz5rdUcawuj4L2tLwETWCDudpbpkJXS6ay5ox
         YDCCrAFbGOQ/wRtY5uB4Emy/FDkasviugheR70QTJTRpAHw8jmGBLe9XrZXcn3nHda4n
         B6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912747; x=1745517547;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbEaFqrqcUxdjS3XqjhcgfcBPZB6s63BuuIBYQhCU2Y=;
        b=dt35U2p9ojU27dKHzPkO/0lOmmgHAVRCcYoFfX8oMFf6kwGejBCeO7Wgizv7l064uU
         bzKY88Hgwf5EnbKr6rYGIXTFj2qYJ1YN9OKPmg+RktDuDu5OnnxEwoyFTWD0sOZDp26E
         cJL4Ut87YEcGFrn6pLoQ2flr5ADqWbr/ZceQua2R9b9QDeKOHtTL+eW7fV8EUQHfwkDe
         VIcSqtWhEs8ZG14J2sXn/Y48VpYP5QqolJDaihbVnDK42E3ob8BiK4R1aMHjZCJqBVBh
         5uLbka4tvbjVQTKaSbYDca0f7Xgpoqwl8C0U9o3V8Om5euZo+bc8xvQ9CtmJM9GkExCq
         sh+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZjZkzqwQVePxn68US/81HOp65updLktZj/qNKaZZr3We+LmeJmFvcOftIj5Pk+GwFufn9XT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPc7yiWwTTEA/DVSD7lrpakuYcxc6wW2QIwauW09AR/qfXZPNo
	t+PYEbjUklmDPEc6bvyTq7NOuF4TWRP9fJPDdVX2ZJI6O1PrLNYnPlCwMVpLdoWf/qWbyqg4T8G
	D1q15liaKTVh5wh6ig1vXiTOkxBsmROR0ELQD9tzqGWbRnnfwCyw=
X-Gm-Gg: ASbGncumCOEXz70mK5OdoKpXUzpuA4PwxTmiVv0BYXEmF6Xt2glFAy8t0LLnsIGHFW5
	2xRS8fpweiBEDHPtq6LkOP2DM+F4IpdIocad3zXPlBU/5MQt5w8zIKmV1siOHuVjoh+onsEOfyU
	KMD98aqZxuVBXmOsRUndE1
X-Google-Smtp-Source: AGHT+IFooir7yY+sNq5r+D9q8IZR/VrQnuFEnAriFyEGkraVTt9KcCHOVP46v9/DurlPs13oIlKAt/E2BYlhoH6Drpo=
X-Received: by 2002:a05:690c:4989:b0:6fd:25dc:effe with SMTP id
 00721157ae682-706b3362a4amr93359417b3.25.1744912746856; Thu, 17 Apr 2025
 10:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Apr 2025 10:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 17 Apr 2025 10:59:03 -0700
X-Gm-Features: ATxdqUHxtmM2P4b2F40kTPyPJYBu-gM7BU2x3EQWneqGKxe6FOF0JxnhTwK1XOk
Message-ID: <CACo-S-01E8LDbpO6deP+BLQqUuJjm-eCw_ndUWPsH4-QdKikYw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.14.y: (build) call to undeclared
 function 'devm_of_qcom_ice_get'; ISO C99 and la...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.14.y:

---
 call to undeclared function 'devm_of_qcom_ice_get'; ISO C99 and later
do not support implicit function declarations
[-Wimplicit-function-declaration] in drivers/ufs/host/ufs-qcom.o
(drivers/ufs/host/ufs-qcom.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:1fa560e5791dde6834e1ec43155a855c01ac98e8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  4adfeedc792504a29825d04911880ae45e82d9f3


Log excerpt:
=====================================================
drivers/ufs/host/ufs-qcom.c:128:8: error: call to undeclared function
'devm_of_qcom_ice_get'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  128 |         ice = devm_of_qcom_ice_get(dev);
      |               ^
drivers/ufs/host/ufs-qcom.c:128:8: note: did you mean 'of_qcom_ice_get'?
./include/soc/qcom/ice.h:36:18: note: 'of_qcom_ice_get' declared here
   36 | struct qcom_ice *of_qcom_ice_get(struct device *dev);
      |                  ^
drivers/ufs/host/ufs-qcom.c:128:6: error: incompatible integer to
pointer conversion assigning to 'struct qcom_ice *' from 'int'
[-Wint-conversion]
  128 |         ice = devm_of_qcom_ice_get(dev);
      |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68011f4769241b2ece0f85eb


#kernelci issue maestro:1fa560e5791dde6834e1ec43155a855c01ac98e8

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

