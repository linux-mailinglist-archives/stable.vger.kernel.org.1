Return-Path: <stable+bounces-121130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD45A53FBC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89031893E43
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D871747;
	Thu,  6 Mar 2025 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VdeJpHcO"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38922094;
	Thu,  6 Mar 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223872; cv=none; b=AgDrhF6PEtezYdkgChHiXA3/Sulfdf5nIrKuTyTaW+jTppYvwyU7auShWNTyyGmOzbCxzfikikNkMS8IVmEu6zdItyAM5YZ27HZ8dNb2GO6dfuL6tM1eEw4zNfYTtIZvi04uzkewFE0xFe2VIihPavLa+m+yuh2RlopyMvj4m8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223872; c=relaxed/simple;
	bh=d8mOkaSxGAgITAm/BsLBpX3YnchGNDkwWdTznfAgOm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVJcefMzAQNZI9aZTcABJHgtlTb7py/fgX5RqVNx6FDeuerfTbuY00zX8EQhcm9ahiuW/QLY9hWKpuzoQ9bEVBlDkl62+cYzcvz6Hj5/oYVPDTtEluEIlj894j5d/5pKHkmT6vXrnHRL3ktEyKEUSigZqYS5vSyvaPBDnGTAd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VdeJpHcO; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 859ABC003AAC;
	Wed,  5 Mar 2025 17:07:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 859ABC003AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741223279;
	bh=d8mOkaSxGAgITAm/BsLBpX3YnchGNDkwWdTznfAgOm8=;
	h=From:To:Cc:Subject:Date:From;
	b=VdeJpHcOB6Fmc2C/0BEGa4w+S38QjM5MXZTsv2Pfnw/Z9NLis0tjB/A9VgtIKqEg4
	 1AHNwAt7Vl7f2Lbis3sZiQLsVGc6H0nGg2Ev3DimDYYgJ6JsNbQyXQHB//tVTZVW4U
	 /ENYWmSZ//x7Igp8dGt7J6Rf+cc5i4Lw1BRWz4/g=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id CD5404002F44;
	Wed,  5 Mar 2025 20:07:58 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH stable 5.4 0/3] Missing overflow changes
Date: Wed,  5 Mar 2025 17:07:53 -0800
Message-Id: <20250306010756.719024-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series backports the minimum set of changes in order to fix
this warning that popped up with >= 5.4.284 stable kernels:

In file included from ./include/linux/mm.h:29,
                 from ./include/linux/pagemap.h:8,
                 from ./include/linux/buffer_head.h:14,
                 from fs/udf/udfdecl.h:12,
                 from fs/udf/super.c:41:
fs/udf/super.c: In function 'udf_fill_partdesc_info':
./include/linux/overflow.h:70:15: warning: comparison of distinct pointer types lacks a cast
  (void) (&__a == &__b);   \
               ^~
fs/udf/super.c:1162:7: note: in expansion of macro 'check_add_overflow'
   if (check_add_overflow(map->s_partition_len,
       ^~~~~~~~~~~~~~~~~~

Kees Cook (2):
  overflow: Add __must_check attribute to check_*() helpers
  overflow: Allow mixed type arguments

Keith Busch (1):
  overflow: Correct check_shl_overflow() comment

 include/linux/overflow.h | 101 +++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 41 deletions(-)

-- 
2.34.1


