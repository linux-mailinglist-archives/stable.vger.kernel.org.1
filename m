Return-Path: <stable+bounces-158788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CDAEBA14
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567EB1C439B5
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0A2E718C;
	Fri, 27 Jun 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7jGoOG8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6E3234;
	Fri, 27 Jun 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035300; cv=none; b=JhqcgXqnviaDUtd/AL3DeQzqv4yAV1fsiGx5B/peZtMkraZl4Dq1Q9qj5Obs8q9cC/Ay9yS9l6mkkeKgOPIJaFv9CDSVDsir7B+f/KBcCTSOtG/nae14iICsGSol+VohS8FJ/llqQVqWqPMuxJ3EYwsmPjUGL7q8tcdtE/pwhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035300; c=relaxed/simple;
	bh=eBTAjbYxNXhiEfw1Pw48KCE9G06Yeyt8BnO4r4Jre0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFv59TnndwLqZI8teBaHOhR+kUDGH0PyT2fNjoptckyudgMB0mFyib4trbCfnm0r8yqjgkQUuzsQzR5XXcFCvBE8CzWQuf3vc8luiAjTuAm91ZVE0jE9YtUuRKHsoH4yEom7Q7UvMYtLtbDEROuP28k2TYp6Y92ngj/rz6Tea+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7jGoOG8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751035299; x=1782571299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBTAjbYxNXhiEfw1Pw48KCE9G06Yeyt8BnO4r4Jre0A=;
  b=I7jGoOG8vX7A985rfM+Lz6Wf5IrlhZfn3xVHpyKQpLL6oe/4+XyMgkYO
   6pE+N+NORBUf5gbS7TQ/+dyLM601jSASfpgJKZM3H98wMivLtCceiJzNJ
   ZLImMl9BVIncefgSGsu1cSOPDIuL1e3VpGvRjeE87HDLZGMP8tlMR4x7O
   SteYOeFMgt89VSivcBRsH+o6F37P83S1aJuGXLGtdcPbr8ur/azKRsqDa
   u3iC8buk/hZskyu829h0UTSGruxQzdcTgNXgk15hNmFHfijIJncdYF/VJ
   tBRQxeS+YqCAX2u00pJm2GD6XGKh9X8mj1miJYcMWbSxd8ZhK/HixQCaq
   g==;
X-CSE-ConnectionGUID: ZBAfFPABRP6YCOUJnY9q/Q==
X-CSE-MsgGUID: WzDrYg5FTfWzlbDPFTjdcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53444940"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53444940"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 07:41:36 -0700
X-CSE-ConnectionGUID: yvovHnSxSRCUrPYuUXjk7Q==
X-CSE-MsgGUID: u74AGl21TD+8gR6FdFBa0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="156872925"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2025 07:41:35 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3/4] xhci: dbctty: disable ECHO flag by default
Date: Fri, 27 Jun 2025 17:41:21 +0300
Message-ID: <20250627144127.3889714-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
References: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

When /dev/ttyDBC0 device is created then by default ECHO flag
is set for the terminal device. However if data arrives from
a peer before application using /dev/ttyDBC0 applies its set
of terminal flags then the arriving data will be echoed which
might not be desired behavior.

Fixes: 4521f1613940 ("xhci: dbctty: split dbc tty driver registration and unregistration functions.")
Cc: stable@vger.kernel.org
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
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
2.43.0


