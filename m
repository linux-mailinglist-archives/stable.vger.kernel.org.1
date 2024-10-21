Return-Path: <stable+bounces-87641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA079A9175
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EE1F23362
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9091FE11B;
	Mon, 21 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE6XsPvx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9A1FDFBE;
	Mon, 21 Oct 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543537; cv=none; b=h8R+S05TQf/rljhCx6I6zsdv6BLcpWWhbSRLiVmiLJzBjvLutlkVKYDbaisey7Xnp9ktdxsPfbDOfeo1TjFR9lWWrBHjFo2nz4QRlWafyAtJbxhXESE453KQqqNd2vNGLfA7Kq27+HUHusDmmI3VsFYnPF/9Ru+g5OzCz+Ml9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543537; c=relaxed/simple;
	bh=w6NXKVIyw1kaqdbze/Lw/u07zmd53GQIC2q0s88hSRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHFunQmsKXxEwCU8YnPs5ltoCosEjdtHOzMc20U/W5yWGSsz0vaSyEYvgkVtMaa5/F8Xj+VKvH4Y3DOQ6S+I3XqPsnf1f/aPcnd5zvjz1bf7/fpDWABORMhgLXm5piYj+y+cWyzsmAjT4Aw+P0auQXiUw15zoup1d0MK9Sf5CJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE6XsPvx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so3796969f8f.0;
        Mon, 21 Oct 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543534; x=1730148334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDRboVblVc9uDKv6XTsqY/eORK+gbYPrarQMQD9pPX0=;
        b=RE6XsPvx8GE8KbjxPOeOyR5MUKNRMvaofTEYtjQV6c+Yjwpj0UTnKAMVIi8SCmi+3J
         ibrTegcEWXXIC6gwMeK9wytvk1Nsseo62KdYD0G0ijxJQDlIkbqyiYbLNbTxwjXuBJ0z
         jI2/XP3Prn3/+UdnGP0OSWQHoYVXeMhtMBdq0XFDSiDPD/u+0aGz8yXHf4joEUXKvXgz
         Kzri/ksfX8I2reQa+birMPrVXQaG6PuYCcOFlMMYSxdN29yU+blpL4NyZeG5cj8LGJ/U
         8vb62NP2+UgumKmmcWlUOIF26oiHeQmtxffGBpUkfx/gmi9zg+BaG6/qwrrmmRi7ZALm
         R8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543534; x=1730148334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDRboVblVc9uDKv6XTsqY/eORK+gbYPrarQMQD9pPX0=;
        b=f41nxRGzmwBa+MyoiEP+7zIMUG0HK97VSSPM/142gNdr7vNZ736G+89FPr4MP33jrb
         +7yrxKVmH3y77+6a4z7n3AaaqFKxPmZO0e+uwgWDnpcIzoX75B3ZGtFjQqrugwaetITm
         6fAtMzrc+Ery+kVHSF6zQO51DuFl2lzr36tKtp813YX8ISIgXpM/IeetizAWhXMFOD1z
         SJAmFL6sQRA3rv3Oe60ZHUYuVuVq+QdU8Ids+hLf2YoOPs18Y68qftFlTXoZi0ctGzWG
         uaIKRwO6oEihyUGBMWQoCFhw14cz85Gh2+XJJlP5bDuE2N7ya57eoZuE9J83Tw8sQpVI
         s7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUmK8S4VAn7ri4CymKvJGcWNgth0jtVZ0HIYxKhPc5kmizEv6M7bdaQBl9R7sjjE1KdOCT1EIzR@vger.kernel.org, AJvYcCWZO4lbZyLskp02uUIO7ZV8OHcz9wakNn6sP7hzCL/dH3hFtWFI3lUk6TQD3eVI7wJEWZjt/IDy0ufqd/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgyOwdBl3PV4HZWJTKAGuB7/6TB0uqNer+UJ7Y1r4NbL4Gp4DV
	YsGLtIuyPELG431im8Id5HFRRBki7/UlvkZCnIeYmk1Dz0Jx17in
X-Google-Smtp-Source: AGHT+IFXTcx40MryoSH/3xskgQ7Lce/y/OnjX7UHaTibP6PFRUsy5zHpRuQsaSUYcbN81rgc5Vx+jg==
X-Received: by 2002:adf:ed11:0:b0:37d:3171:f2d4 with SMTP id ffacd0b85a97d-37ef21ac857mr274946f8f.43.1729543533770;
        Mon, 21 Oct 2024 13:45:33 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-023d-d91a-ee8e-da73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:23d:d91a:ee8e:da73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d49sm68483595e9.7.2024.10.21.13.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:45:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 21 Oct 2024 22:45:29 +0200
Subject: [PATCH v2 1/2] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-typec-class-fwnode_handle_put-v2-1-3281225d3d27@gmail.com>
References: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
In-Reply-To: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729543530; l=922;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=w6NXKVIyw1kaqdbze/Lw/u07zmd53GQIC2q0s88hSRQ=;
 b=ATavkCxMukaDJQDmwHcwdCrGyIWNzqq++O7wiM0KgtNUCKpGmJ088AoTiFy5RjY5Pix/hFFnr
 uwOfoMumcbLBGn/t97YPYvN1KzV/kmsuGDd28QKSeTXiWr0Mpijb1WS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'altmodes_node' fwnode_handle is never released after it is no
longer required, which leaks the resource.

Add the required call to fwnode_handle_put() when 'altmodes_node' is no
longer required.

Cc: stable@vger.kernel.org
Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/usb/typec/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index d61b4c74648d..1eb240604cf6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 

-- 
2.43.0


