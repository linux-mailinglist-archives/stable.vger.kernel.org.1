Return-Path: <stable+bounces-128957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF56A7FD46
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DBA177D76
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F2267B7F;
	Tue,  8 Apr 2025 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmhLbQ9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EE266B4B;
	Tue,  8 Apr 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109735; cv=none; b=lCUyI8ITka1ckvT7Df38LhlW31W3fU7o7kkJ7jr2AFnTf7yrWX8hRGR7Ro9aS9w8e4YpbV+Vh46450T8c+gzBmQelqvalgc0FYNvBdUMmmJU62kseYJrgZ0wG7PNl2BXFF46LNR/B4N76FIB9CjN+XrNGtTd2yQzWM60naXiy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109735; c=relaxed/simple;
	bh=QgU5hGamMNji3SvjeAWbv06dOnWuJUxXyfyi9F7piFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz4szKvY1EcvtnLNM1fsEWL8POW2wJx87ZOHKL6vLsl8rF2zMzVGre73GuA6f0cEJevVwkawRluzlcI+usKnGqMDMd9zD2oQJN8kpM6D/vjspVmlQetCsMuqL+zdnsQzaZFLH5Hep8TpSdn5M9VupoYarBozmjW5xIKxNsEQYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmhLbQ9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E77DC4CEE5;
	Tue,  8 Apr 2025 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109733;
	bh=QgU5hGamMNji3SvjeAWbv06dOnWuJUxXyfyi9F7piFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmhLbQ9EbFjAWy3r5KXG5+mgXJdRd7NqnzVQ9n85PACOPOAhJqCWHgMUraR1HUq2p
	 20YunOPfKd3ZJ5FYEnq0fky62brKWxYMXHtXkVMND0qOvfOkXYCGIzNKllfGLykVCU
	 iPAjxCBTZrVNACw7pHjeC4v9DtqeRawajTih4XxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 031/227] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue,  8 Apr 2025 12:46:49 +0200
Message-ID: <20250408104821.338332831@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit 32ae4a2992529e2c7934e422035fad1d9b0f1fb5 ]

In some environments, the SCLP firmware interface used to query a
CHPID's configured state is not supported. On these environments,
rapidly reading the corresponding sysfs attribute produces inconsistent
results:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  3

This occurs for example when Linux is run as a KVM guest. The
inconsistency is a result of CIO using cached results for generating
the value of the "configure" attribute while failing to handle the
situation where no data was returned by SCLP.

Fix this by not updating the cache-expiration timestamp when SCLP
returns no data. With the fix applied, the system response is
consistent:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/chp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 93e22785a0e09..0b84ced33b3ca 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -646,7 +646,8 @@ static int info_update(void)
 	if (time_after(jiffies, chp_info_expires)) {
 		/* Data is too old, update. */
 		rc = sclp_chp_read_info(&chp_info);
-		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+		if (!rc)
+			chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL;
 	}
 	mutex_unlock(&info_lock);
 
-- 
2.39.5




