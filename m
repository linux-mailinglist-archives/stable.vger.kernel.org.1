Return-Path: <stable+bounces-83263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E699752E
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB93B254A4
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77841E0DC4;
	Wed,  9 Oct 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFdtEiMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A71DF734;
	Wed,  9 Oct 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500168; cv=none; b=fFTq7+T5/RNWyNa8silSPt74ygOAn1NntfN5B+fFNt3soU2h1KeHmbCv9ZxLVwlaVoxHgaS5Oy6ZuVM0qm0T5yRSai5Ipa03x32BDjbpwxBXsKCMIQ6XmuiGC3b78THB2y7YIjusCURB3BHdduBIBDE8VWwK4NW3KVQ19tfxQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500168; c=relaxed/simple;
	bh=bDmdoVXY7CIoUgvBCektb8QqAKjFivIrLKLaMALmR8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RK4W07g3ORSyobUyYkFDmpPHtfTp+g70Np2ONCZGoh3yqbQ5hpKDwv4MQhp5gROD79/AO/bldPduF5jFT04nusSjx4gB31L+9HSvKuZPe//o8pdUV5Pd1Xyb4Yb94ScNYW6mtwJtJ3QmvL73HroLntdeEqD2LIBN88baEXeOIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFdtEiMe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccd81de57so92966f8f.0;
        Wed, 09 Oct 2024 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728500165; x=1729104965; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIpvepU04vQBrfFdCPxrz99wuy/omHJnmjxH9oK+R3c=;
        b=EFdtEiMeKBYoh/1f02Znu04eubotSLbFmTZyNiekGV6BDwcECz+roVofIjEnR9kM5M
         KUncT7jlNkKg0fj0PN8SXkvvDq6CACnsgZ8mMSd+1IBJl/+H1G8efuUiVEYolpKGDXo6
         qhSt0jGS0Udq38W12Rnelc48mRmZSCiBw5YUKTJhR0pJ/CCbFjFsD9v9NcuTLeEq3qZE
         mgg2BIcnMfN1BLhg4jQW+6r188pAPR5h1BnDlXU4Jt/quHOJgwZVrvk+aUOojUCxuSG6
         wbihTqq8l0z45xnGBn9ByuJLriZPcIuB9lo6xM9OPkxV3GoQJFrnmdp/fOSLqD1hbHn6
         LvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500165; x=1729104965;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIpvepU04vQBrfFdCPxrz99wuy/omHJnmjxH9oK+R3c=;
        b=YR77l2jsNOMXFdMjHKKRNqaTROWn4Pve2rzYzC7vWKy1q2or3liI/pCtMdMBefAPph
         AMXjbhZBGq5ztvixEKsJ74ZtdpBNWeNPc8SLqUeQ75wGJ+khu4Njg/VoCsiyb6vLTeKO
         gF5MCkj5O7w6H5GDCpzKMbopmPjv05HXOUt4Ir7+t4Noa2w4UAIePUSEVcel4WvP6Exr
         gRwue8Y5EY+YYt507JZgDl0sRm7+9dXAISgkvPflv7ApZ5uXHp/HeJVNFiuFlJCwji8T
         SJsvqdz63pqxMCDpWIWniwaDET7kzrlNZFfeQFHiy6b8EeyMYkn4l9VOI36PZyYu9yO2
         85aw==
X-Forwarded-Encrypted: i=1; AJvYcCVVQ/LH2n8ldYcmprh7mtRGv68MoLvxWMBd6nMibyUw+eVAHgId55WoNHTr9f42PcWprTrTJ3YNq6Aps6g=@vger.kernel.org, AJvYcCWxBQUolsmaS9D/M8iri843UFDZ7ZRzXSrxUdmD1ih2nXqQxNlndXaRfklpJZ/XQHLIJLTnYDL1@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzGUaPK49glu+4iqC9HQC4lmPpCdeOBmZ6mHZkwg6dl2s+zYX
	5jjXo1OxlXwS3tgGtnRDGrgNZww4dsDhZCFAA7kE7fFlu7ATnGOW
X-Google-Smtp-Source: AGHT+IHse50ItBhMs4WbNWj7zCSStUhkgvCUXnkFifblSKxOnGbsgqfGOAg30DPZ4LeSggMA6sQ05A==
X-Received: by 2002:a05:6000:12c7:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37d481d2de3mr535398f8f.28.1728500164528;
        Wed, 09 Oct 2024 11:56:04 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-268e-1448-f66b-a421.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:268e:1448:f66b:a421])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e606sm11098835f8f.69.2024.10.09.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:56:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 09 Oct 2024 20:55:44 +0200
Subject: [PATCH] platform/chrome: cross_ec_type: fix missing fwnode
 reference decrement
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-cross_ec_typec_fwnode_handle_put-v1-1-f17bdb48d780@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK/RBmcC/x2NUQrDIBAFrxL2O4Km0pJcJQRpdG0Xiopr0paQu
 3fpz8DA8N4BjJWQYeoOqLgTU04ipu/AP+/pgYqCOAx6sEbrUfmamR16175FGN8pB3SShhe6sjU
 1RnNZ7Rrs9RZBZkrFSJ//xbyc5w+tKpxncgAAAA==
To: Prashant Malani <pmalani@chromium.org>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728500163; l=1888;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=bDmdoVXY7CIoUgvBCektb8QqAKjFivIrLKLaMALmR8c=;
 b=EmUsMKkTErMHN4XM+jmurxP4+C4URCWyPOGoOx1wI8mwEe4xW8V9rGPTrAe0arwMzUPp9AxQd
 VbxhZp61SbaAUJWQym7tAgwREsrnndOM0fPqTerlEO1e3dCy5Vi0vkE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The device_for_each_child_node() macro requires explicit calls to
fwnode_handle_put() upon early exits (return, break, goto) to decrement
the fwnode's refcount, and avoid levaing a node reference behind.

Add the missing fwnode_handle_put() after the common label for all error
paths.

Cc: stable@vger.kernel.org
Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
I usually switch to the scoped variant of the macro to fix such issues,
but given that the fix is relevant for stable kernels, I have provided
the "classical" approach by adding the missing fwnode_handle_put().

If switching to the scoped variant is desired, please let me know.
This driver and cross_typec_switch could be easily converted.

By the way, I wonder why all error paths are redirected to the same
label to unregister ports, even before registering them (which seems to
be harmless because unregistered ports are ignored, but still). With this
fix, that jump to the label is definitely required, but if the scoped
variant is used, maybe some simple returns would be enough.
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c7781aea0b88..f1324466efac 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -409,6 +409,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
+	fwnode_handle_put(fwnode);
 	cros_unregister_ports(typec);
 	return ret;
 }

---
base-commit: b6270c3bca987530eafc6a15f9d54ecd0033e0e3
change-id: 20241009-cross_ec_typec_fwnode_handle_put-9f13b4bd467f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


