Return-Path: <stable+bounces-152274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE36CAD34CE
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C683B8173
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F11E9905;
	Tue, 10 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfwGoFjS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBA221F00
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554293; cv=none; b=XzpgxKvFeZkComzdzXLCxYD1hTpg7ZFwMlz3PqL2OHkErwoKSX0Mzs/5JfjkUHzQOGNowDl+rWe41jpH9ewfe82kDmYPrVbBhqZveleX8asD+HvrtWsCmIKIViqgXtRa8oHaRdKQAhgU7wFH6ARAYZR01lJEoKffudmLGFnwqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554293; c=relaxed/simple;
	bh=PM0zF5DzT7Cu7t5Rle7p8zUkEHvppzRE/c1zpFkqlI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8lZZnuzaLTYdraSQg5DJL9Qtyc4t+9/upkGSI7D1xstshZxT83xpRyPB/Brkxv8oBkImevu0S+w00W/z/aATgQhjQmxMI9msy3/E6EriaKdT5kRHe5raENNkBjkwa4aJrh0Pnc6rhp4zGdNGpaXcyysZClDgVNCpnxsxTYISrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HfwGoFjS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb47e0644dso1091973166b.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749554290; x=1750159090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3b2BnxfS/ZKr8bAvdMa5zb253LnX6qkONKFTWI64AA=;
        b=HfwGoFjSIfYBKw5jXke1sCpyUr0I84jBgoXQu00WALJdGRty2HGDeHva9zTTxh8nqf
         Mkx4nu9BSZLIdx1ulA8wv8zVBi2TxWvAveTyAv8/K7nulqeIe6dG9zxn0+UgeFZNLzca
         jmf/bgdmV/SWGfjxh4oh/rHMlPWdolyb3nilE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554290; x=1750159090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3b2BnxfS/ZKr8bAvdMa5zb253LnX6qkONKFTWI64AA=;
        b=QnjajISTb7Jz2USl2fLLVIN8CErx0TXcfyRxfeZRDi/wqA9NsFVAHsQh/y3AnsPLB6
         D+bSlH0ceo/CtRba3pDzR8VD2Hezd6Ua9EadBSzA7wGpdPNsRAoJTHscf3k1OfbYQJLh
         Wj5FxFsuiMJlngkqZw6KvR5RZieulJNQP2buxOnkB9OfoxBGQwXjFyxEB5VCvTleBisl
         H9bgpdXDznTerMtizdzJmeUPsskX+N0YiKOIotF1MXua14AwTqodLJtHFFt3MVrCtlzh
         VsP8AXbIBjRp81My+yCG6k1kbKka+/vreai7vdVJCg6MxOBO9WI64gGr6HDOfG9MT38H
         8AqA==
X-Forwarded-Encrypted: i=1; AJvYcCUOVscel0YnfkZe+yRjhR9F/AA8sgLkatnHSIMZGfqcxpJIIrEKAhS63SGRIBIILwSgtU7cEGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpioMlrbfJzXB3d/UTJk/Wnas8cGquV+PGKqRLa/O5Qk8TJ0cm
	xK8EK3wVBqV4pG6MYAbUT4VDiG6uP2LV3LTAHn+ZldOViqKwI2uFiTaSLSaYX3Sy
X-Gm-Gg: ASbGncuskjo5DUa9s3D1BEw0lFVgtZ37+tN0ki+O/hJLJqZBvwXtQ6izEKoBF2PRojG
	kE7zvD4sFQJ5cf/0TEKnfdKQxzns3UQ8FVhqxj8wq39mirMxOidLdsFYMPM2x5VaAcUi6dcaNSl
	ZbrdPXvt/VFNL5uGOYKS1PlZXkjBE8zq6yNJm+8Yn6TDocwq+duMIewt2Bz35ntxCD0MaRI2Ect
	JM/SDvTiK3Tq1IYc4/+oN0IkQ+9Th8s1CFsec1ZBsEbncOjdwuu36mTTCPB6jozw5bOUDu0Rjt4
	OQ589K7NXyA+DzxwIkQlv+I4l2rYoqgioVqIcE99Wd4I6WMRdcFO2OctMWjcNUaLhQZe5YPsExd
	54Hu3kRuNOoFlrmgfzw/4Rz0OQQa9CCTwReudLEGcR1NO
X-Google-Smtp-Source: AGHT+IEUeFqTG7VrqDTXWeyOgxbO1okrDqsRKQORfqK9YT/jfrmzkm2FpON3MSspT/lzk0kEU/P4sg==
X-Received: by 2002:a17:907:d869:b0:ad8:8e23:86ef with SMTP id a640c23a62f3a-ade7712b1c0mr256940866b.4.1749554290095;
        Tue, 10 Jun 2025 04:18:10 -0700 (PDT)
Received: from ukaszb-ng.c.googlers.com.com (46.224.32.34.bc.googleusercontent.com. [34.32.224.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c676sm714576466b.105.2025.06.10.04.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:18:09 -0700 (PDT)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] xhci: dbctty: disable ECHO flag by default
Date: Tue, 10 Jun 2025 11:18:02 +0000
Message-ID: <20250610111802.18742-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When /dev/ttyDBC0 device is created then by default ECHO flag
is set for the terminal device. However if data arrives from
a peer before application using /dev/ttyDBC0 applies its set
of terminal flags then the arriving data will be echoed which
might not be desired behavior.

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 drivers/usb/host/xhci-dbgtty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 60ed753c85bb..d894081d8d15 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -617,6 +617,7 @@ int dbc_tty_init(void)
 	dbc_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	dbc_tty_driver->subtype = SERIAL_TYPE_NORMAL;
 	dbc_tty_driver->init_termios = tty_std_termios;
+	dbc_tty_driver->init_termios.c_lflag &= ~ECHO;
 	dbc_tty_driver->init_termios.c_cflag =
 			B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	dbc_tty_driver->init_termios.c_ispeed = 9600;
-- 
2.50.0.rc0.642.g800a2b2222-goog


