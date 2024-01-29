Return-Path: <stable+bounces-16440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DE840CF6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D01C2323B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD3157031;
	Mon, 29 Jan 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="me3zQirP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B10157049;
	Mon, 29 Jan 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548020; cv=none; b=IC4HvVsM5YTfMevxfsWC4DWNxfi0x79Ak9mRJ22L8yvaBKZ6ca4hV5rMQU0QrWHqBAZWCfYKWUbuW8e5UooUvCwLhtxUhGfzXDlttscSEBJ3wRLEi4pU4gfJNM1edmKn1Wq9cbPYZCgL7NNpDMwYJGsJL2LzcucZE109/ZS///E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548020; c=relaxed/simple;
	bh=SC9r1gGeQTaogVE/T7bm53u7KObZoW9ygZNsZG5hVRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrt/QONlgNsl4hbo0ucS74+4EyBXl/tEZlyBWkzy6wOy0YWjgS/1/u7kVM+Yvpbs4e2eqP+kOFTpLBbJV30bxvzGfYGjbpFru5Y+ag8iVpYnDgW5ZW78v3q052fPOGph7eu055CVIFpC1z9hmAs3S+L+hVYyt00QqZeX4C1XwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=me3zQirP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511E6C433C7;
	Mon, 29 Jan 2024 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548020;
	bh=SC9r1gGeQTaogVE/T7bm53u7KObZoW9ygZNsZG5hVRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=me3zQirPi9cC2J/GJODG9nftDkfkWzFFNkacMpfEMNgVgqQmACMn/hL6y/ap9G6gi
	 gXSAeIHbhzXPsiW68YQbzCXMUbWT1AwH6EpY/fvr2FpD39FzGwpMpx7sAL7DTUIshD
	 C7/mrjubdvKnGIAY+hVyBFrvI3VI5v6RPOfi9b1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Disseldorp <ddiss@suse.de>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.7 013/346] btrfs: sysfs: validate scrub_speed_max value
Date: Mon, 29 Jan 2024 09:00:44 -0800
Message-ID: <20240129170016.750321147@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Disseldorp <ddiss@suse.de>

commit 2b0122aaa800b021e36027d7f29e206f87c761d6 upstream.

The value set as scrub_speed_max accepts size with suffixes
(k/m/g/t/p/e) but we should still validate it for trailing characters,
similar to what we do with chunk_size_store.

CC: stable@vger.kernel.org # 5.15+
Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/sysfs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1783,6 +1783,10 @@ static ssize_t btrfs_devinfo_scrub_speed
 	unsigned long long limit;
 
 	limit = memparse(buf, &endptr);
+	/* There could be trailing '\n', also catch any typos after the value. */
+	endptr = skip_spaces(endptr);
+	if (*endptr != 0)
+		return -EINVAL;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }



