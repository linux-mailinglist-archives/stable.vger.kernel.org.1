Return-Path: <stable+bounces-87640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3649A9172
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CED6281493
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3C1C9B6F;
	Mon, 21 Oct 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuHqHcqI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A7433D8;
	Mon, 21 Oct 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543535; cv=none; b=OJg/SJGKXxhuDmk/v9Si5UIcPb1U5oEtGIHC25OB0Zet5bIJOjunRTP278dWbGj10nWWECO/SPtyRgFlA86ATWC208qpU93sYi1X8QpxAVSwToPqn+wl6aXxrdbwK3o/UVdE3abNWI1DEQkJIsBaTawioZ9q2dVJ9uwcf8etITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543535; c=relaxed/simple;
	bh=T6uZ7CWQZiDgr9CvAkblBhr5k6pjIhO5SvXt8Bja7ww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CbnjSR50+xVVAuG0yMOsJoqBsT9nHv/4N3/oXvCfz+ZhDM1cEKBPSQeI2daBAOQ4F5pr7EjA3LlVWGwpm5TO2PiDw0c+krDIOeLdsHLgUslM9t+9NJEK3UqvtMWtttEWCBNEPWPSftTJXTm/Gd6Sd83Y4+AhvVd/NEKQcfq6SWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuHqHcqI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so57075215e9.2;
        Mon, 21 Oct 2024 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543532; x=1730148332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31c+iUZpCze9GrKtOf0yNYd4tZARsyqaVePW4ZzWUuA=;
        b=GuHqHcqI7gbMwyt4H9CrrpKhurwq/gjzmysw+MEr/3stw/323B5gFKkW97QYQAh+oQ
         iHxAQXfgv4oxPhuSiYjnvS9EUsMpO8IjWRGAimO4G0P7IQROdwZB9M6uPZo08pVWAuee
         8IZqCz0WIo3rJFln6O2HXCWDp4XBh/8SBv3Qxy2kLu9Q1+RAXSx49NS810EK9NKHMvRO
         gFh+m2AP3y2Vf2ZCZB7Pwum+Zsv90zNUetFGzMNOv+OLHZrqS8wGhyOHDDFaWkm1Tydl
         xf/1n4ad8aw5g33+RrvEMOzpgaGvtWL9h9aY8zwMEJC4bNISy4xQDyH8+j3BNx3F/i8m
         RtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543532; x=1730148332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31c+iUZpCze9GrKtOf0yNYd4tZARsyqaVePW4ZzWUuA=;
        b=GscjiGBwKDS8FdjPkCwtUKXaLzilH5lepr4Npq4gmCwXSQ12lRnypKoAPKJkZGoF3A
         kLCpGMzWTC4yQfJ7l0bKaBQy8BtGlAVl84crOkjDewB8mSK/dZR88oZ1ySUtGpM8WOg6
         k56ksnw7VabID31+LrcxDr1hI+XP0aD5zJAmIGBUhZM1/2pRDo6scQokPH4QNLnduR0s
         JBM87HxsPEVbw//Pt+ZPMdfoARV7UU82yQdupTf1mi3PMbilna8ZBN6r8mfc/RMBTLHf
         irgsABE9sZjgxN+5UYfehcbPF+zhj3ze21DR726nNqC/vBuwtqATytwdBmuB1mYl1kfv
         mK8w==
X-Forwarded-Encrypted: i=1; AJvYcCU8/QCCfBXrSf0c0WH/LZgjArhWJwaSmAiBl6Bhdmam/S0CEBV8COvhtA7a0cea1zY9JUu5AG78hJgT9xw=@vger.kernel.org, AJvYcCWn/WbsX8PkZv3v9oZNVdl8lwsD4KARPUhBHD+dpTzFs3gRE3OND9QmInX+utMGJCBzHMAch5Rc@vger.kernel.org
X-Gm-Message-State: AOJu0YywBgWMmTBsNwALS8ya79A7cylxTav/EdhmMReuWJB24X5EJSMF
	gN1QEFksmY7Fd9XwRQ2Gfhul4N0ID99K3Zr76kOHoRbKK1qM8YRT
X-Google-Smtp-Source: AGHT+IG/TIA2NgbxWXzFHzYbcpfUSaxs6CdZGsDMs9FhSA569eQkPCRgjkM/DqbaNcUu/SymVPSrPg==
X-Received: by 2002:a05:600c:358b:b0:430:9fde:3b92 with SMTP id 5b1f17b1804b1-43161636661mr144311605e9.14.1729543531552;
        Mon, 21 Oct 2024 13:45:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-023d-d91a-ee8e-da73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:23d:d91a:ee8e:da73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d49sm68483595e9.7.2024.10.21.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:45:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] usb: typec: fix unreleased fwnode_handle in
 typec_port_register_altmodes()
Date: Mon, 21 Oct 2024 22:45:28 +0200
Message-Id: <20241021-typec-class-fwnode_handle_put-v2-0-3281225d3d27@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGi9FmcC/42NQQ6CMBBFr0JmbU1bqIor72EIacsAk0BLWkQJ4
 e5WTuDyvfy8v0HEQBjhnm0QcKFI3iWQpwxsr12HjJrEILksBBclm9cJLbODjpG1b+cbrNOuGbC
 eXjMz+aW4tcpYJQykxhSwpc/Rf1aJe4qzD+txt4if/be8CCaYzo3SXHN5LdWjGzUNZ+tHqPZ9/
 wJSPVDVygAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729543530; l=1026;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=T6uZ7CWQZiDgr9CvAkblBhr5k6pjIhO5SvXt8Bja7ww=;
 b=5Ux6xC5gHtpUIy7U2X7YcqaQRsNfC+Nmz452rlN8Bt1CbASY9RQheBoah439qLfYTUsTPmBwH
 20rqBvBV1pcCS6h0Eis0eKhO+ECNgC/eccqv0+GHX8yfKk8Nv3DNKPz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The first patch simply adds the missing call to fwnode_handle_put() when
the node is no longer required to make it compatible with stable kernels
that don't support the cleanup attribute in its current form. The second
patch adds the __free() macro to make the code more robust and avoid
similar issues in the future.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Add patch for the automatic cleanup facility.
- Link to v1: https://lore.kernel.org/r/20241019-typec-class-fwnode_handle_put-v1-1-a3b5a0a02795@gmail.com

---
Javier Carrasco (2):
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      usb: typec: use cleanup facility for 'altmodes_node'

 drivers/usb/typec/class.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-typec-class-fwnode_handle_put-b3648f5bc51b

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


