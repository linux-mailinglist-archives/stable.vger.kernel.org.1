Return-Path: <stable+bounces-81940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47875994A3A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C4F1C22524
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9D1DE886;
	Tue,  8 Oct 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/KI/mBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B080192D69;
	Tue,  8 Oct 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390649; cv=none; b=fmo/+2MuaDbb80YPNabGQrpbEu31YJygwM7RdBhAkpIL/yUci4N4v9LK1HdWmcjs2zJqWFtZazBdvmrSgyvsUscNrEHFCkCHkS3cM0vebdfqrDU+ReYgH6Zys56iBgASzqAyb6oozmTJ4JsGRCoJL4+zU1aK9suvhcnie6aTHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390649; c=relaxed/simple;
	bh=FJpfb/oxTxS4CUQTNI/f7uio2ca9M5S4X8j7PMFdj0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGKAOQe8uJ+Ni1egy6PdXXatzKNbSZfZWXuJ8r/c5oAbsP6qHoIbgw6B4iNXlFfeq+6IWHyG28pD/tk1cxsU/uoChwk+f/VHlEb4iU9NCxREZDok1mlXNN/vT94n+JyrsXAoCRjsQfCmzAxQqszZgV0hPt9dXdKRaW4WlI2bJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/KI/mBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD2C4CEC7;
	Tue,  8 Oct 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390649;
	bh=FJpfb/oxTxS4CUQTNI/f7uio2ca9M5S4X8j7PMFdj0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/KI/mBGiFzXXd1LFWhFUKqQs3iud1SlJHI5idRKTFWlUIw6TRLFlBN7wuXA1hk1m
	 nUnCPfHg7vd1edsaMqtf8zr/dCDlBz5tTIl6e0YAdTdjBAk+OOXT/X4lP5c0iYyKVx
	 OGg0x0E9vebOgQkw7apBaF+o30D4Sz6VE7meNal0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.10 350/482] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
Date: Tue,  8 Oct 2024 14:06:53 +0200
Message-ID: <20241008115702.199074820@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit f0e3c14802515f60a47e6ef347ea59c2733402aa upstream.

Use tid_geq to compare tids to work over sequence number wraps.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20240801013815.2393869-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -725,7 +725,7 @@ int jbd2_fc_begin_commit(journal_t *jour
 		return -EINVAL;
 
 	write_lock(&journal->j_state_lock);
-	if (tid <= journal->j_commit_sequence) {
+	if (tid_geq(journal->j_commit_sequence, tid)) {
 		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
 	}



