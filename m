Return-Path: <stable+bounces-159226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E53AF11E2
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533D0524726
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226823A9BB;
	Wed,  2 Jul 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL+5t2r4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95B24BBFD
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452124; cv=none; b=brLFV7Z5LOLTTGI4/6zU5ufcIEcPzIwIiSk0a1GYNwVleawzSdzhS1/J/oh2o3d+Fao/wcR3O7EmVpinpVQ/gcEkt1Xu4V3hCV6v+fJjhRrMfohakjY2GJtr7tFABlxJG/PLCCn/3tDxsDbXzNVqiyBoDKMmyQuNJIZk4NArNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452124; c=relaxed/simple;
	bh=B/h9MRznXev5O/HfAfxUcmA/LXRmzcX2v2wUo66X37o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXh2UKM3cblUYKKeiE0sBggiXztiEbCgPOfRfIv/+Fhu1aPlx30sRGzrcPTFXe0GHyaR8cJYsrHF5P3wNkkBu4uYmW+mbd2tiSb5xbPLfhede4ReNa2Ty3+9jF/S/GuwePykhwEiB5lutlCar+H5Tbe9UkG7GQUl+PrgT4QjyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL+5t2r4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45348bff79fso41974335e9.2
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751452121; x=1752056921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35Ckb+nEVvnGK4uJNuAw5o/jjDFypNplCX6urkQxX2w=;
        b=BL+5t2r4eU2rnkuF/d2zyTPBc6DZWVFhA34KTBQcg2otB7N2LnvT50Mop2ldBQgKJu
         Vo8UNnAMJkvN4SdENVk6Hp6DCFtJpRk8VGTtZly4/b3cN0Ll7a++F6V9RUBjnaDEmyqy
         0rmi13aNOaRZve3vFDavzUXPhk0WwoyM3tB3Wx31+/QPaJUwBwN1QESn4TS8SsBGZ/r5
         Q3MbqkPGnfUEp+7XJZSX2NeQmsT/fzltOztSvOo2VSnOlzf5ZR7zJD0PKQ3VGtfBHvUY
         8qqP+hmJT+WnTnNtYj863DmGGEeggIo5cY2w2QmngPgF3lheR6D9HOw3rmQslGDBkvgQ
         dYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452121; x=1752056921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35Ckb+nEVvnGK4uJNuAw5o/jjDFypNplCX6urkQxX2w=;
        b=H3f8A+RH5WHREfqe3H20/2pUvmJPEWRb6oBw6hc9cgCmxK0HfvkvLGIQmUQ8ChJcAi
         VPrxK0cyUibV7QnKtkJc6mbv7WP/D7QCRPNDOth2HKMzojqHBl2ICq2mY3N9ftRGUYm3
         QPcALE1ae0hSSUkpVlVfW/hpWZ6klA/nlAGE+3BiGVfdBhlG1asK5xh/i2tWiy6PVLrC
         tcQGE5WE7iRjzQutO+Hc/EOjvBXv9b8WPN/XfYwx3roxGhpmsrzNPEf3Egqz5rD7HDLC
         ww4LRB2opWlWAzAbId0goOKQkrsVAedS70UCJnUwH7TFWwDaS9UH97U8RYEWDIZTWE4x
         OosA==
X-Forwarded-Encrypted: i=1; AJvYcCVskfCORN5bCNVX0d1+cpXf5z8Zx4n4SvI4N85aLW3vAsOnZmKm1URVZxcMd+DATs3gRs4be2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfn5/aRporuH7ct/Fd0wZ0TEnAz6pQpaSPXeshJvpVnQjmRdQ8
	taw1ORquQVWbgQgq++CcMm5re/vGUbZb7+yj+ikhhsj0WQsHDndNSIlf
X-Gm-Gg: ASbGncv0UkycnT6+LPDEFgw4N8wmrMe/OhlOE+Abfi7MFtRv+WAeDoUbH9AhjEx44Tt
	PEsc9CMr4h7hTcixyBm7OCqLG/SB6gVn5l4ohgOjvZjJufh73mh8zsCMKnhALFPbpKz/aW/DGHH
	TfomuC1ki0lQ+8ooV9qAkVWN4t7paJEnN5xTVddIBkHQ5KeI/OEW9t2CGa4xhW1m378nldecQz+
	YrZfFHb8F5NMbbpcumoiKKvgFzEE1yQo5Xsy8HJMBrA6Gtkd8+JAUqqkuNwemNS3TqNe1S2FZis
	BhVr0R4E7CSD4gCHEv2tIsb4ukWGK2x/uKdoh1gzN+6S91CiVXVKnayZbx35PVDhw6n2zbvaXrK
	Fce3BGLWeXrg=
X-Google-Smtp-Source: AGHT+IEEgCatIx9H+7mZWG/K7njimodbCMwDyFXgeSzO+jIu8cHSLkrDDXvaDz8SoqtIueu5tSYnPw==
X-Received: by 2002:a05:6000:25c7:b0:3a4:ec23:dba5 with SMTP id ffacd0b85a97d-3b1fe0f0915mr1686768f8f.5.1751452121299;
        Wed, 02 Jul 2025 03:28:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm224443185e9.20.2025.07.02.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:28:40 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: gregkh@linuxfoundation.org
Cc: mathieu.tortuyaux@gmail.com,
	mtortuyaux@microsoft.com,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 6.12.y v2 3/3] net: phy: realtek: add RTL8125D-internal PHY
Date: Wed,  2 Jul 2025 12:28:07 +0200
Message-ID: <20250702102807.29282-4-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702102807.29282-1-mathieu.tortuyaux@gmail.com>
References: <2025070224-plethora-thread-8ef2@gregkh>
 <20250702102807.29282-1-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 8989bad541133c43550bff2b80edbe37b8fb9659 upstream.

The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
clear yet whether there's an external version of this PHY and how
Realtek calls it, therefore use the numeric id for now.

Link: https://lore.kernel.org/netdev/2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com/T/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
---
 drivers/net/phy/realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 830a0d337de5..8ce5705af69c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1114,6 +1114,7 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	case RTL_GENERIC_PHYID:
 	case RTL_8221B:
 	case RTL_8251B:
+	case 0x001cc841:
 		break;
 	default:
 		return false;
-- 
2.49.0


