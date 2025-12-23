Return-Path: <stable+bounces-203329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A02CDA48B
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0959300A9EA
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F932F691B;
	Tue, 23 Dec 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="fPRvi/jy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CB238C33
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514909; cv=none; b=bmGHi6JrOuF2JygTxeiOZKbaKFR2Ta7UfdzcAhjBZfhi1sRVAURsl7bXvH/iwvoh3dclYJUScEu2zg91ry2awKx2iRJkpwTK9k+IJ/GbnM9aEkgnJpulppEUxmf/tSr4C90BKvZ6UQ6Z94sOcFbotbb132aDcGJraaaYQHV1w90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514909; c=relaxed/simple;
	bh=4byZAlrLosiEW9NoUIj5SDUDzh/hDmghUGCSptvyuvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAczSEx8MhwZwqpaenVpi+225KlBYd1vKGOewrLxpPnlNplb1ulkZIeQnXNzCgcHUGv8lmXb1ZKa1fTNp38fRtJYAyD7PYfqrpROlTkId+a3OqoQz0RoEgmzybahildPKjVKRhhiq1r0L+o1iSa0jJoH5OTR1h2bulj92zhCHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=fPRvi/jy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34abca71f9cso633110a91.3
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1766514907; x=1767119707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4byZAlrLosiEW9NoUIj5SDUDzh/hDmghUGCSptvyuvM=;
        b=fPRvi/jygKr4sC/9ABqpv8oINlFzlOLedNDd3sGPbyjDLS5bYQP/vV9ywJVp0/vS10
         vI4k5mUPAK7jiQgeCmfmpTF0vccoDNk3Ldkd0FvykMopMyJ6RUDWaBlrqWkeYIfmKZqY
         Dx4oSmaUFfn8F7rSa8MLnKb6/gkrQMkTtZlKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766514907; x=1767119707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4byZAlrLosiEW9NoUIj5SDUDzh/hDmghUGCSptvyuvM=;
        b=mmoDEMzFW79CKfj3cYsW2Y1khBhI8PNbSedu1d/k4/6iBkebh7i4QbeCVtnaWnNPRY
         GFkcQ7O5l+QkK5jDzXZvlnuBS/fEj6bJaYndspnX6M1beavazAl+zXklUJZXxLCZeW5+
         5ieFhz3C4O1qo9kybAXunSHNgLX/eMEgUPX+2VX6sptL9GP1a2m872CPe9U4uQD+No5x
         Tnq6/PoNh9OmVuIwAesVVJOAlxV/Ux8f5WWCBHsro7IrqzZ4rk9W5lgFfDZNACmcFAt2
         6355yRtf0GW5vEgf7RutO6Hz+cijs6NcM07R0xS0BMxbzCVWtTAOB++GoVZr6eERVCWW
         Cghg==
X-Gm-Message-State: AOJu0YwsYWyvO1yI+Y2HKu+IpnPv0UoLhH+IdDpEF4LJ69ktr4oc8H8w
	rKzaPSJ8b+JNeuSXkAS5u1pXxm/JSPznKHU8eIIj5pPV7bxLnjy8830nSvFRtp8EWA7QvDLldQO
	eHOpB
X-Gm-Gg: AY/fxX74mA9nYl+FfJsWfTOJ7C7WG6E1+WWvNoS3SH/Pmzib5JBwi/j9thJGn7gylGc
	/7/ZrKbzKY3JUjnGCEHkfBUypU9gOBcFo63BP+61eSPwNBaUgCQ3AvrWktERLm+hBTOuFQsuJrG
	avTjF6GIP8my7/EdfLPCKtaT9CWBSOKdNZMsME3uYo7IGMoimMMBLrWCV4E3HSipqDb5bGOPXE8
	bdM/CM4LX65jxF+Bzc+OmtrOCa3299tISXBTE2TdKSKQIOomnV+jG0kxyyvpbYzTU55UMmEtchW
	Xngu6BU2lq4JyCCY7Hmz3fsEDHPWXbSh1tKMU3vrUTEP9dSzrX5rSC4a9lbvleu94Z8CrDAFk7A
	1wjq/PLWwg9ADnDqeqY7aN1YLmLhBzjajTSUa/dYeYGuYQu8Fuut7Si5YbVDZ3+2X/AUtgboMCK
	CCInWDg2Kx9WKpkNR0/MFc0DGO9N/bkRim
X-Google-Smtp-Source: AGHT+IHicD4ICZ1eEVkn1bjLoDDmXVMfL1Eegg6wp55aL3yQNuyT4flx0b/Y61kSRDBqh6bmajgaQA==
X-Received: by 2002:a17:90b:4d8e:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34e921c4431mr10158030a91.5.1766514906923;
        Tue, 23 Dec 2025 10:35:06 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a1778esm12551811a12.13.2025.12.23.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:35:06 -0800 (PST)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: syoshida@redhat.com,
	davem@davemloft.net
Subject: [PATCH] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Wed, 24 Dec 2025 00:05:01 +0530
Message-Id: <20251223183501.1850707-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223181453.1850174-1-skulkarni@mvista.com>
References: <20251223181453.1850174-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Please ignore this patch. I messed up the subject line, it should have been "[PATCH 5.10.y 5.15.y]". I will send another email with the correct subject line.
Apologies for the inconvenience & sending HTMl part previous email.

Thanks,
Shubham

