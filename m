Return-Path: <stable+bounces-121381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1DDA5687C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0119817846E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7821A433;
	Fri,  7 Mar 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WEBVnXHH"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63B219E8F;
	Fri,  7 Mar 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353004; cv=none; b=e1xV1rVeDa6ZpgO3Dxc1Hp3TQ/dPoxOHEaG+sS1ee2OGwkIyB2dKhCZ63HXFFqcEoLlkUYEHJ43ShwzzDFH3khLtu+U0xlHZNAlAJlMHdsqEPzj3lcWetWD0gA5Ep2WewPiJXEws+1rLocMBrs5eBaLnbPiHm90PDg3xTnlhWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353004; c=relaxed/simple;
	bh=GomPSVqWX5HDexYxgDtcgWTkvdBqFVIJtdELBVbRNhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZjoSEmJHzA+QIPjlujDKpe0Hiow0dpfe8ALgpbIndmBVoI3L7YbqhKNyjUIxJiPQiuv1opCTHgOACJlnPaSJgqMDbmjR1ETO/ajD7FvV36q91th0uHOmu798U0eQbwIU9+7QjhuEY1gK9D/777j1eFxZ0XzxtiMNYh07JQqTaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WEBVnXHH; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F1FA7C003E19;
	Fri,  7 Mar 2025 05:09:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F1FA7C003E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1741352996;
	bh=GomPSVqWX5HDexYxgDtcgWTkvdBqFVIJtdELBVbRNhU=;
	h=From:To:Cc:Subject:Date:From;
	b=WEBVnXHH+J/alcvb2ysZ7Y977fuJeaBHU99nykZj5JI/TU+1qmDOOCGhmJKZoMvDa
	 lljohXSBiIVCUZyMXXmH7VjmGz3q1uJ56TJC1U/ZC1/PahTgIZ6ugDTr5Z9TpyB7Ww
	 HWw1lhUCZA/pCyU8QYUP7LsDwuOWcvcCYPAWiWf8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 53EC54003010;
	Fri,  7 Mar 2025 08:09:55 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH stable v5.4 v2 0/3] Missing overflow changes
Date: Fri,  7 Mar 2025 05:09:50 -0800
Message-Id: <20250307130953.3427986-1-florian.fainelli@broadcom.com>
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

Changes in v2:
- added missing upstream commit ID to the last patch in the series

Kees Cook (2):
  overflow: Add __must_check attribute to check_*() helpers
  overflow: Allow mixed type arguments

Keith Busch (1):
  overflow: Correct check_shl_overflow() comment

 include/linux/overflow.h | 101 +++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 41 deletions(-)

-- 
2.34.1


