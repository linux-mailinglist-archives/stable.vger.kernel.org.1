Return-Path: <stable+bounces-142950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9BAB07A0
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17397A4748
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BFE1FC3;
	Fri,  9 May 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqRLnopt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9828682
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755559; cv=none; b=uVnqa+pVLQ+suNXEx51as/7btsZFtRYbQj0mogbERsBpbhT68g6kQix8Ui8gEQJxXtL9tlQXNwt9RMMwiVtsIX8yVE94HBv3w18DYgS907UhJtv4QLjR/qVWsyJHqhjp7TsDB+kuMZNJKED/755kxzswWWofWAlbaEy+H3Vp65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755559; c=relaxed/simple;
	bh=eBYF8/3GVQro2dSDdUTaXgH2UYCgzW35Ou/Zf35tkgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjOievBsj1SMCDwk2EqO1iyj/T5ia/b4nzR0u7d9v2ftNifY/edizGhdWXcAzgWACZApTe2HZ5WoElcUwT70Cd7hkwCR0k7aLyo2Emrgn7khVyNiDdAY/s0Fl44XbUxw+B8V4V+32fi7Ysvr7ifn+n7b2lz1dMvWh9PPj+Y1GRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqRLnopt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656CEC4CEE7;
	Fri,  9 May 2025 01:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755558;
	bh=eBYF8/3GVQro2dSDdUTaXgH2UYCgzW35Ou/Zf35tkgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqRLnopteT+vnY6Rbhuo9HUB8jZxvvVisisEPiDehPMCQzYAdjBVMfzNjxw+nbmd8
	 d/LFAQKgvZoigKPIjYVw2ETCmOlwB+wCLj7nNZWk4ZZl7Ngic3syJJz8dbpSOpZP/y
	 p2lV0OoHSZWwNry1VExyxbuox26NfE08hYq0J+BLRUMuhX3zYPxvY1JIwtWjJKs0KJ
	 W7UwKevJDPv0qOgdFXXaYFAAODfO4V821LkMgLuxd9wleEVg1id3BmekehohsS7Gaw
	 oQah6mMMkNpF82ky96mYPipSaxcB43+waljakEjzd09w1p0XstcO4z72CamO6mJXNu
	 FtwIAK+1eQ38Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kent.overstreet@linux.dev
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] bcachefs: Change btree_insert_node() assertion to error
Date: Thu,  8 May 2025 21:52:34 -0400
Message-Id: <20250508135854-9bc02251c704108b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507183051.3235368-1-kent.overstreet@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 63c3b8f616cc95bb1fcc6101c92485d41c535d7c

Note: The patch differs from the upstream commit:
---
1:  63c3b8f616cc9 ! 1:  fa08530b7ad9e bcachefs: Change btree_insert_node() assertion to error
    @@ Commit message
     
         Print useful debug info and go emergency read-only.
     
    +    (cherry picked from commit 63c3b8f616cc95bb1fcc6101c92485d41c535d7c)
    +
         Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
     
      ## fs/bcachefs/btree_update_interior.c ##
    @@ fs/bcachefs/btree_update_interior.c: static int bch2_btree_insert_node(struct bt
      	ret = bch2_btree_node_lock_write(trans, path, &b->c);
      	if (ret)
      		return ret;
    +
    + ## fs/bcachefs/error.c ##
    +@@
    + 
    + #define FSCK_ERR_RATELIMIT_NR	10
    + 
    ++void bch2_log_msg_start(struct bch_fs *c, struct printbuf *out)
    ++{
    ++#ifdef BCACHEFS_LOG_PREFIX
    ++	prt_printf(out, bch2_log_msg(c, ""));
    ++#endif
    ++	printbuf_indent_add(out, 2);
    ++}
    ++
    + bool bch2_inconsistent_error(struct bch_fs *c)
    + {
    + 	set_bit(BCH_FS_error, &c->flags);
    +
    + ## fs/bcachefs/error.h ##
    +@@ fs/bcachefs/error.h: struct work_struct;
    + 
    + /* Error messages: */
    + 
    ++void bch2_log_msg_start(struct bch_fs *, struct printbuf *);
    ++
    + /*
    +  * Inconsistency errors: The on disk data is inconsistent. If these occur during
    +  * initial recovery, they don't indicate a bug in the running code - we walk all
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

