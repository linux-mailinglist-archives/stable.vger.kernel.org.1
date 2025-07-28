Return-Path: <stable+bounces-165010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B3B14263
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3D54E1160
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EA273D68;
	Mon, 28 Jul 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBE/H5yO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93272777E1
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729661; cv=none; b=as5W8/O13hybOxSRR4cG0KkxKkwEMVfsk0yia/x+b9WwXg7UzFnHKJdyB+RgwVIRXo+Cq7syQyNlN6PqGxuy6XS7K8/D6NOrMy7clNeOIdwTNAuNsHKY+R1TV3AY6FR1pLVVAuuOLWFjaRIvK2h/yffYqjhaXwGU0++sI8uvobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729661; c=relaxed/simple;
	bh=hKZUbtEx3GOkGdZ54AtSAuxwkuPldHxQLxNXlGE2NbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=saUq+09ZXauex6Cti0qwbEuzgWwNMICLJPxLPeoBGu8GppxLg0XTxL+FupSPwX/k0n+rNraGhk7r9ooM/4gupgCfziBr99WYQ7oq9n+X1ppMQo/E8KJnrRfX514zaugGI/safNUwyMDMMocaxDPFfWfq5bNJGy6m9dMkJWw2fTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBE/H5yO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2405fdb7c15so3469125ad.0
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753729659; x=1754334459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKZUbtEx3GOkGdZ54AtSAuxwkuPldHxQLxNXlGE2NbI=;
        b=fBE/H5yOa/OOD2uQrgqxwvBrBUMuzP0vViPLsN/LROHeqmsWGCyvKtMRSseX9fjkLn
         IEXiCTmVjqVVhRdLoSvl9An6n52pkBmTDaSN1Gf8Q2z6u7C998ZrC/lkdcBJEIYntCDy
         KA3ylUXh8GROYCI5W3qr6XoteXF+aN+DFkaOsU76VrU3OpIQ3QjvWC0INfVxeYx+7wqY
         R33G+jXaqA6AWcaVtH+VSLipeEmQf+KV5GRa6yfIu6vEgcTA8HhLzScKJdrDAwdraXDK
         evqPkTMW28NDnmRcyTSK8cNFasScbAq0VIMluOOYP2C+WG3PC1wyE1AavoBVMPhNZMO/
         ibDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729659; x=1754334459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKZUbtEx3GOkGdZ54AtSAuxwkuPldHxQLxNXlGE2NbI=;
        b=N5tQcpSZRYnGswl4dDiFhhUDVtgE2S3iMoPRFwsNRQGAKlhfSpfMxSHPr6N7UtQVLt
         CQadYsRdOPYo40Bi32Q4yXgHfdCQR27aEPkE6XiFxctPImDo5p8b9NxmtSBpH+qWFplo
         nYZKWNbCP/NQdGkwgntL343G2ZI/YGUgBM/ly5sGHu3evvlbgHss9bzzzfWBqq7uhhjV
         +12qR/1LnafrMsoNf+eMsQIhLbs4DHWGo1SsMF2IeKldPT9Av+33rFcWGwQXj+xpvuGz
         h67j0rk1O6ud7Jkytg823Ial/3YvMlBSEaEpNo4dqjJwLOBQGdy3FhOOUaTcfjOFqiQy
         boTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9WkPY/+HA0zqp/8j6L1UGp2GxUDPND2vh5g+ZuQ0L4kLLsEbhV7QgSgKiRZxilznASvu7lZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7E8OfAqN13eILsM9//CKitJ+2H1wT26bFKOin/Acsvb4Y5+QQ
	zSIS3wZA8H0vGtC+QKbxYodVHkWNyBD4t3/D5rpu2O/nQagfSzKf81X3ZE5X9HlKFy5EPguPAii
	8W6HUIOldpW8eZA==
X-Google-Smtp-Source: AGHT+IE+DwrXpZ7Kd+MAcLmq52iVsx/0YgUkFszdkUYexmdFDWTyJejFxEfkeMlUnZmDWdb6RqlFKH5c+4kZMQ==
X-Received: from plbay12.prod.google.com ([2002:a17:902:8b8c:b0:231:de34:f9f6])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64e:b0:240:14f9:cf13 with SMTP id d9443c01a7336-24014f9d124mr70638715ad.51.1753729659059;
 Mon, 28 Jul 2025 12:07:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:07:37 +0000
In-Reply-To: <20250728175002.4021103-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175002.4021103-1-chengkev@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250728190737.4128256-1-chengkev@google.com>
Subject: re: [PATCH 6.12.y] KVM: x86: Free vCPUs before freeing VM state
From: Kevin Cheng <chengkev@google.com>
To: chengkev@google.com
Cc: aaronlewis@google.com, aha310510@gmail.com, isaku.yamahata@intel.com, 
	jmattson@google.com, kai.huang@intel.com, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, sashal@kernel.org, seanjc@google.com, 
	stable@vger.kernel.org, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Please ignore above patch. I replied to the wrong thread. Sorry!

