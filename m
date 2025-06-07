Return-Path: <stable+bounces-151755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DFDAD0C76
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CAA7A9E0B
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CB20D4E3;
	Sat,  7 Jun 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgXua8IJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CA20CCED;
	Sat,  7 Jun 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290903; cv=none; b=bpFT9y7z/WGj02sZ4+FVM5RjyTL29bBeELeWL0UGmNtPHawIIoRRUGlv/vD8anJ2M2/RHgQtcC9gf8ak4Ur1nXtirDmzXMfNmv14GUc5Y61Sq4cTv8MJz4Q+e/HaOaXCfmN3OHKHclySIzLnsa7n9TmY21z+janoxGsrISODgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290903; c=relaxed/simple;
	bh=mZC/Dx0fWVdOHBq9Ft7g/yt7JsTi+venWL9lac01dtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfO/JCzMrTN+IxkRIkvS4IidquDyrW7Wx3ckgZF3YqFHlhIc4dCcCZzftuYpekptyHRl/VcemZYJq8iaI9VKXd8ifgCS4lsrWCE/jACbULr4CWREmSzfq8yAb6M/Wp/wgCJO9cN80nKT02GzWBx6xa45pLvTIlBZPb7q+cLOGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgXua8IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8248C4CEE4;
	Sat,  7 Jun 2025 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290903;
	bh=mZC/Dx0fWVdOHBq9Ft7g/yt7JsTi+venWL9lac01dtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgXua8IJdXtzMmUozm2Rl5YQRFVsBfa6AcSh1QIWeb8/HLEXib/kpeHGUUYS7Zr0s
	 Y9xbTsSInhwZHXw8qwTfYaXpIhsHiv93oIpiDtgb3DwvTSbeuDj2YLc7TJgPUC/078
	 lGYDF37RKAjj0JwIkaIKqIYxqV9Leyr6xGcn+/50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qasim Ijaz <qasdev00@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.12 17/24] usb: typec: ucsi: fix Clang -Wsign-conversion warning
Date: Sat,  7 Jun 2025 12:07:48 +0200
Message-ID: <20250607100718.572620013@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit f4239ace2dd8606f6824757f192965a95746da05 upstream.

debugfs.c emits the following warnings when compiling with the -Wsign-conversion flag with clang 15:

drivers/usb/typec/ucsi/debugfs.c:58:27: warning: implicit conversion changes signedness: 'int' to 'u32' (aka 'unsigned int') [-Wsign-conversion]
                ucsi->debugfs->status = ret;
                                      ~ ^~~
drivers/usb/typec/ucsi/debugfs.c:71:25: warning: implicit conversion changes signedness: 'u32' (aka 'unsigned int') to 'int' [-Wsign-conversion]
                return ucsi->debugfs->status;
                ~~~~~~ ~~~~~~~~~~~~~~~^~~~~~

During ucsi_cmd() we see:

	if (ret < 0) {
		ucsi->debugfs->status = ret;
		return ret;
	}

But "status" is u32 meaning unsigned wrap-around occurs when assigning a value which is < 0 to it, this obscures the real status.

To fix this make the "status" of type int since ret is also of type int.

Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250422134717.66218-1-qasdev00@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -367,7 +367,7 @@ struct ucsi_debugfs_entry {
 		u64 low;
 		u64 high;
 	} response;
-	u32 status;
+	int status;
 	struct dentry *dentry;
 };
 



