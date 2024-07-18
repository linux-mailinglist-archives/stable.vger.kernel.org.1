Return-Path: <stable+bounces-60575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11876935183
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AA41C229A1
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1F14389A;
	Thu, 18 Jul 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCyRyQgI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA078481D5
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721326498; cv=none; b=j2CTGcA+quCyHIHE8wVceNI8RtCHrJ70cHbBK5M+yTl8lmS+TlahDLvWoiX7IrulptmzYzsMSaftq+c2+01cIoHAce8ZiJZE8JsIRHyPjhnsPhdI52WWxYGMupc9pB8xGL0zvr8l0Jyq1Y2YSt0AmoE3xKTRsh1uQettn0TGkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721326498; c=relaxed/simple;
	bh=5euImxvmUYbTm5qYQt/pHALFzLSfzhTLIKHr4hO6vsI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=esIm7dyueOPzsaavgiCR5Mb7k7JHUAzMg92NJL7Bn3J6YFpGI6oSzZcOuKugiKooHKwWVHZGQX0OdiWslw2kXMlqAO5zmr+KZTsNpYJbi7JENGdLwtWDbFebmy/f5qF+WghYuigGTMo869dHlvA1yFvXlDWK86/iq77P0N+3HuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCyRyQgI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso970298e87.2
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721326495; x=1721931295; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRt1r/uSN4EIZAqUK44oMEvfoK9M1zxZWsIeM5SYq3o=;
        b=iCyRyQgILkBtbrd4vnnP5azJnDT6vW8CGSlAZ9Hj2Vtozjn0MZWGlkL7TRS/EtUnOL
         7KT2+8N1ktyJJKPubs5zwzOkcnPBbq7omMamcS7ooS1PhOdE+PJgyVga6CVrTxh0H53G
         t7x/JvuSeqYhD+KqPMS3LhSuEDRMUhteRW3uqEbGZDgKqWbKLiTkbDilPwaN4HKLDell
         H1jr6tp64bDThLCxFFxHpd8Ks5996QACVTL5CYWc8hwMi7sW8P9QBNSaUHcLoVLGuAOG
         BetcMe8nPt+vOS8OX4fIqUwSx+Yo56by1mp4xu9vF8sNEJofOKU5V4psSuCx6n6hAPWN
         uxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721326495; x=1721931295;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRt1r/uSN4EIZAqUK44oMEvfoK9M1zxZWsIeM5SYq3o=;
        b=Z9QSt9z801VOvJsAzBIyj9r0HSqEuVPlU4mbnAuOlC4f+jjW2BsJWPDW2YgUubgo2T
         BUygPWU8pELKyZiY+XG6tQzuMCjmLmkCy/u+I4omiUWpvv+LJ62wELFKgsqJ5S/vE5hl
         /Z6/l007V7SuEutql1NllxAAD8Vz4uTy8Hst0xIUlwCfYDyNU0HheYkOooiaOz0qe5Bl
         8EI5c3yHabo+2JSAmyKf6KpOoZu1DZXCLwwPpoeteXpvXziUFobyawDENCYxHmphyEux
         +TrECvrc/Kq62ECjnJS1/F7d4xbf1T468Zl8ckP44kzm+w9mFQiAuZ2ERotxjHGuhbME
         9U5w==
X-Gm-Message-State: AOJu0Yyb7VAu2wGD0rIQSGwHD/FjmfVVvgluyFNOGyiNWoxEUz5/1Pnk
	goqvciHjLTK2j3aMrFYmCKhUK5pfDD6kZsj5P/oiKLIN16h41vWspcYEyg==
X-Google-Smtp-Source: AGHT+IGbjNEVroDNdyU2HV6YpbcgCGQPP+7sWkSrSnuIB2R2x0YVXpm06GtpbYQ2oXhBEW/FO6ec+w==
X-Received: by 2002:a05:6512:4016:b0:52c:9877:71b7 with SMTP id 2adb3069b0e04-52ee545279emr5260863e87.59.1721326494407;
        Thu, 18 Jul 2024 11:14:54 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:8c60:6f94:6b54:464e:1d5? ([2a09:bac5:4e23:c8::14:28f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820d68sm581011366b.190.2024.07.18.11.14.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 11:14:54 -0700 (PDT)
Message-ID: <e10727bf-d914-a902-9e46-195ca28799e9@gmail.com>
Date: Thu, 18 Jul 2024 20:14:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: stable@vger.kernel.org
From: syphyr <syphyr@gmail.com>
Subject: Missing writer side af_unix annotations in 4.19.317
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Several commits were made in v4.19.317 for af_unix to fix race 
conditions. Most of the READ_ONCE commits were added to v4.19.317, but 
the WRITE_ONCE on the writer side did not get added. For example, 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.163&id=5b9668fd874144d02888e55bb95ed5f4aacdf703



