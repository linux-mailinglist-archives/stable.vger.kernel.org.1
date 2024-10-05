Return-Path: <stable+bounces-81165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A0991698
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B766F28478A
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77B1369BC;
	Sat,  5 Oct 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcIC8A5W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DA82D91
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728129629; cv=none; b=H7J8eVFas0DkVestYtKEkm2/P5BFCRBBwnnQyLYKoOJ3E99k1K1NhBUfgmxP6vn+7+fSjSW17jjYVmTC7bFNNrFvzXVliqMmdmxU+UbNtLXdCqrBsGW8+ROU4D2MlxmZ9CkkhhXqRn74J5spZrv9LshSFckLfI57/aUYX4CcL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728129629; c=relaxed/simple;
	bh=w0JKuoAPG81v+StMfitbXi++EH1Ue4WZPwh0RljI4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SUHyq5G+YsXZmJv9KMvsblzGn37f1PPkTnbSPNYQQypfKDg93R7byTh1ouh8x9aijb7vt90NxUtlS6EzZfwBuihwVOQXYVcnLfh6iARGW2XfExwaRDHuX3n0SjScwiNQQUYQHD2+6mjLbVvBBHM6o0huT3FpVS55zm3goHkACtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcIC8A5W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a98f6f777f1so388595366b.2
        for <stable@vger.kernel.org>; Sat, 05 Oct 2024 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728129626; x=1728734426; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w0JKuoAPG81v+StMfitbXi++EH1Ue4WZPwh0RljI4f0=;
        b=TcIC8A5W2JLzdoVkML+zdeB722r1LCSxJD190X+YxDdHRHPfFqidI039vGf5u1o8QW
         e/desvlGgcPZ82FNlqJlQcS3/2KVivSAtcv4ev8BOPqlsRuwRnTqGpOuFptVTcDUHJJp
         cArKE6oX5F01HbsSDq3muSQlY+DTRbKmzPCIrSLquGQ7ajqmKqqds69m8QiDxEDJKfxk
         lRCP0zELeuOiyBWOvTa3iSyu+POgBSR7gLUq2X66QVyYHFTuB7aUpQfsl3he6FszPn3O
         jv8gN03TCcGDUp54C1U84La7er1sTf+Z1PuW5XZSwTFHlCgwHphkX/opV9ssE9Q8NVjs
         Ujtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728129626; x=1728734426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0JKuoAPG81v+StMfitbXi++EH1Ue4WZPwh0RljI4f0=;
        b=OlHkLehWN5imJAdaA5gW/fNptj34ec3hCimu3U7ndwRGZmV+H0Mv1qWC45P29E3Kvb
         LsTV47mUYWB25q96lL5y2E6lqI0WMMgj+sn+SFLMr/SuQZM2viYcHjAwxJlSlS6l4Qim
         F81Z/J/JqZoOr2Z2v2Y1qsLPwkiAis9nufSTq9i2YZGWt0uje4dw/qBUMmg96QLiQn3w
         WdvAPwC7edhSb4safQtwQh46QB+s2TWCco2X+1uUe1IlsoSTnz1JlcoVPrMXvq7xIoRp
         P8aX0sZH2/m9ya3eSG/zCJ1mYKiFA2NVm+lrrHEbcMi32qqWPSBp3I6Ih757FS8gdHTc
         xNvA==
X-Gm-Message-State: AOJu0YwYXgzSMiCIcIGap8GOBsdTR2GAp9YrpGWnMQwb1/SrkpcxKwoH
	kQwGjW20tdWQPOQVbSd17M3vIJaKmrZeRCSRqyjhNd/U0Zn8ADPW
X-Google-Smtp-Source: AGHT+IHRjd26cTQ4rHBXt/C1SgSPcjr0Pa9HY1ivk2gDuQP5gd+lLeTtqwxi4q+58l5H1BErbyjzyw==
X-Received: by 2002:a17:906:c151:b0:a93:9996:fb16 with SMTP id a640c23a62f3a-a991c077de7mr601469966b.64.1728129625858;
        Sat, 05 Oct 2024 05:00:25 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9945ce60ccsm797666b.67.2024.10.05.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:00:24 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 23705BE2DE0; Sat, 05 Oct 2024 14:00:23 +0200 (CEST)
Date: Sat, 5 Oct 2024 14:00:23 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Bar-Gabay <morx.bar.gabay@intel.com>,
	Andreas Beckmann <anbe@debian.org>
Subject: Please apply 0a6ad4d9e169 ("e1000e: avoid failing the system during
 pm_suspend") to 6.11.y
Message-ID: <ZwEqV7J97fQz-nMx@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Andreas Beckmann reported in Debian in https://bugs.debian.org/1082795
that the commit 0a6ad4d9e169 ("e1000e: avoid failing the system during
pm_suspend") indeed fixed his with suspending with his Lenovo Thinkpad
T16 Gen 3,

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1082795#21 confirms
the fix.

Regards,
Salvatore

