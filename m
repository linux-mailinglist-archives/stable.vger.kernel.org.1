Return-Path: <stable+bounces-179632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B948BB57F28
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317773A224A
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636C30217C;
	Mon, 15 Sep 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="OO9hFSAI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24861C700B
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946919; cv=none; b=IeZ7MdOn2a+OAs4nDDOIYo3awj+Ysvsg6FRlfhNbynHAF/yrPgbMhHnOh8VEiGfuizrFzXmnmMMGFsW4KD9kakY7K4JCCBsE2kxNSY98LD/G604ZE91weWanKPfB8rI37wPgK51jG7OzB2nhC7bUf8SxWcQ92O/Y8t/m+tha7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946919; c=relaxed/simple;
	bh=0VsWNLTd9ylwn+QoPr4YmoQKkPOQWdVwd5YylLcpM78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GhhW6dnzlFKZV5LnK3AHZy0rTZW0ekSBEq+ra4dH0Uf/sVEbXJnDX1HmJYjPpZVIPPbusmuXGSMiAXGltltw1eG3qBpuHyDtaVToj0HhBcM8+jY6/saPcUqIRNOtejtqhGfFtY5K1iKGFMoiRdLNRwjJyJE2Z4fBO1+rO2J8iUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=OO9hFSAI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-776379289dcso85240b3a.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1757946914; x=1758551714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPDb1LgGCl+kv/Au5bK0NNM1gZf4OEIqKGFkGmxWX7g=;
        b=OO9hFSAIsF0oic1Lg+QC9B14P3AMes9iQ+/WRcwpc41CkmEPG/DJUcuipWvzVNUyBO
         2Phi5juq0rqWE/cJh63IXYoeCUL1BVl7vmPqoti5WVbIZk+rcKznLlq++XLTFN/K8D9X
         lXNqclOA1gFUuwdowYgv3skKed6bMAhOdRaX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946914; x=1758551714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPDb1LgGCl+kv/Au5bK0NNM1gZf4OEIqKGFkGmxWX7g=;
        b=DXRtQVd+gv6zwHxZNpYa4Nx4R9kfgsY2E3pNQxyyxypyhHe/EBImGQRpXLhujE4+Vp
         W29lx5/fDe4ZoykFvD3fW4XIBA5ldnFFvF5tNVG8habg46cFyZvwCVBK9eIud+QD2/8y
         oqu/8qvmgibB/HP07cf0lvPQcD8JZFU9+sF5bBYbKi2Mt2LqshhIaPqXYJIF0fyH86LE
         Y/Nb0YOwHB/goIsnreFWrQU+FOmHVLPvswKbXG8Z0o097yYeF2af3aLxNSLY6vRdydZc
         mM84GK4X0LV0UJOgQGTBrO9waf/ZYJ6OAVs1/o3LJcwfuP6Iwh8eyQuoAMGI5/fePJkr
         Tm8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOmXkWiS158DyRFDc5DTEMnlKnvoQI4mhpWN+x4bNBaAHv5O9bAa4uy0KPBEUeDDrLtCZDeYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd6LMxTlibq2I2nUMU6cWkxUuTsMj4/935bNO+pjNIcPFASeb
	pBuut+gNWh6lohOzFpWNflmNPo501nEpgvE18hOT+pII5oGGxHrqMs6aalZObqdY2XU=
X-Gm-Gg: ASbGncuwQ/tUrV9wuOnhNQ3KdJe7KnMb6zQkfFKlFhuXRvb44fcY0SXRguV8yYHWUGP
	m5zjQ07aiOmzvQbJfKfmZpAOoinu21EdNnWDqfv4rR2feijAfDLvxSAnUvn+dbfvLbGoKCSJFXi
	AudQ4tuLbEOHHEj103Lw3zITK8uEswSxVaoBNRjDcHXhwcVaeSbTZPkHVYQ8JhW//SQ7dC6U0AL
	BcpQVZUbcBpDpnDCXuGkob1T3NshKQye0gg5yz5wwidLH+vZAPUqzRGDfr2tG+q1sgp2U68tLQW
	//AKj+dAktQZyQWg5erSrghdFwaURnjoiRmFyT4dxa+cgDmwnmE7nIvI97iw17SGUQBjX/Pws/E
	tt/n4Zc3/42bBGmXcpgIMkO9PN+YN7m2HDg==
X-Google-Smtp-Source: AGHT+IG0g1SLvadEUf12b4ySPk41SRpeDT1iDlrUpnNzhsKcTPSGW1DQxXBq4nosWcpEk5JIbSHc8Q==
X-Received: by 2002:a05:6a21:33a5:b0:252:2bfe:b649 with SMTP id adf61e73a8af0-2602cd27895mr9423338637.8.1757946913758;
        Mon, 15 Sep 2025 07:35:13 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398cfbasm12001361a12.39.2025.09.15.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:35:13 -0700 (PDT)
From: skulkarni@mvista.com
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	gianf.trad@gmail.com,
	jack@suse.cz,
	stable@vger.kernel.org
Cc: shubham.k-mv@celestialsys.com
Subject: Patch "udf: fix uninit-value use in udf_get_fileshortad" missing from stable kernel v5.10
Date: Mon, 15 Sep 2025 20:04:59 +0530
Message-Id: <20250915143459.450899-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Greg/Sasha/All,

Patch "udf: fix uninit-value use in udf_get_fileshortad" which is commit 264db9d666ad in the mainline kernel, fixes CVE-2024-50143.
The patch from mainline was first backported to stable versions 5.15.170, 6.1.115, 6.6.59, 6.11.6. Ref: https://lore.kernel.org/all/2024110743-CVE-2024-50143-4678@gregkh/

But later on, this patch was backported into v5.4 with https://github.com/gregkh/linux/commit/417bd613bdbe & into v4.19 with https://github.com/gregkh/linux/commit/5eb76fb98b33. 
But in v5.10, it was missed. When I looked at LKML to find if there were any reported issues which led to dropping this patch in v5.10, I couldn't find any.
I guess this might have been missed accidentally. 

Assuming the backport process would be the same as in other cases, I tried to get the backported patch locally from v5.15. The patch gets applied cleanly, but unfortunately, it generates build warnings.

"
fs/udf/inode.c: In function ‘udf_current_aext’:

./include/linux/overflow.h:70:15: warning: comparison of distinct pointer types lacks a cast
   70 |  (void) (&__a == &__b);   \
      |               ^~
fs/udf/inode.c:2199:7: note: in expansion of macro ‘check_add_overflow’
 2199 |   if (check_add_overflow(sizeof(struct allocExtDesc),
      |       ^~~~~~~~~~~~~~~~~~
./include/linux/overflow.h:71:15: warning: comparison of distinct pointer types lacks a cast
   71 |  (void) (&__a == __d);   \
      |               ^~
fs/udf/inode.c:2199:7: note: in expansion of macro ‘check_add_overflow’
 2199 |   if (check_add_overflow(sizeof(struct allocExtDesc),
"

I had a look at the nearest stable versions v5.4 & v5.15 to check for any dependent patches, but I couldn't find a cleanly applicable dependent patch.
I will give it a try to backport this missed patch to v5.10 in the background.

I am still new to kernel development & mailing lists, but what I know from Greg's other conversations is that missing a patch in between stable trees can generate regressions.
Thus, I thought of reporting this issue first to the mailing list, as I am not sure how big of an impact this would have.

Thanks,
Shubham

