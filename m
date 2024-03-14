Return-Path: <stable+bounces-28131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E887BA9B
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2CF1C20EBF
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23706CDA3;
	Thu, 14 Mar 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r93pmtUV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74127692FC
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409277; cv=none; b=rEtvMAhIBpZS9H+ifUlAr8nbVMvLS62TgAiYfNz52Ive7wKJnOevCktz1lsv0B7ZsHuSJUcSy8avkHgdY/HltSehOm9x4Od3Zo2tRA7/8z/RvHdyHBpnf75V4qV6iP0xdmBKxvt7oNc107H0YQq2F3wqK7bqoRDvVqJeXRmCm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409277; c=relaxed/simple;
	bh=EMeC9MWPb1Y+FEuZdul6qG4qvxKy3HzMMfQGtWMKdNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OJX+B19iI+PRYgu+Gx+u5QmJcb/PND5hjnr8nAJqYT1hRlNj5TEC8KbKY13RGfr7UcrHLxUCwuJF5ls9jzWdceFikVtLPMNp3fvVM4eCymyasSHH7OxVW0yVQ2ai+q9jp74pqxtNYi57LvHigxscpUNrFgaDNKvj+EhgDobkByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r93pmtUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B82C433C7;
	Thu, 14 Mar 2024 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710409277;
	bh=EMeC9MWPb1Y+FEuZdul6qG4qvxKy3HzMMfQGtWMKdNk=;
	h=Date:From:To:Cc:Subject:From;
	b=r93pmtUVdRNlGl7whpshPN3htUtGAuN0MTm5IxxJrR2YgTk1yo6eWlfpTk/P27jMs
	 g854cmp6PgNlDnt0w954hxkq3e1z9FSl/36iwEBTGiM3kPoBo5gWH5WYr6inzBroCa
	 pLcQ6XA3z8SsvI4j7+HgUhj36g2FZwaO8LPVFoIikFzXoQWFKXsEZwz+LfmENGUeX+
	 wioRYmvImfcHbDnHdKUXH6Fp/55sCXurYqZdfaI5t9Rz9V2iFpJ8YggEZgPYPU1D7I
	 n6jjB8m+/zU0IOEaOgJq+66aisJSK/uvx8/cBVZbV/TMJCT8IywAVt4sllGcIxz/sY
	 yLRnpsjGhhgaQ==
Date: Thu, 14 Mar 2024 10:41:12 +0100
From: Helge Deller <deller@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: dddd
Message-ID: <ZfLGOK954IRvQIHE@carbonx1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Greg & stable team,

could you please queue up the patch below for the stable-6.7 kernel?
This is upstream commit:
	eba38cc7578bef94865341c73608bdf49193a51d

Thanks,
Helge


From eba38cc7578bef94865341c73608bdf49193a51d Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@kernel.org>
Subject: [PATCH] bcachefs: Fix build on parisc by avoiding __multi3()

The gcc compiler on paric does support the __int128 type, although the
architecture does not have native 128-bit support.

The effect is, that the bcachefs u128_square() function will pull in the
libgcc __multi3() helper, which breaks the kernel build when bcachefs is
built as module since this function isn't currently exported in
arch/parisc/kernel/parisc_ksyms.c.
The build failure can be seen in the latest debian kernel build at:
https://buildd.debian.org/status/fetch.php?pkg=linux&arch=hppa&ver=6.7.1-1%7Eexp1&stamp=1706132569&raw=0

We prefer to not export that symbol, so fall back to the optional 64-bit
implementation provided by bcachefs and thus avoid usage of __multi3().

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/mean_and_variance.h b/fs/bcachefs/mean_and_variance.h
index b2be565bb8f2..64df11ab422b 100644
--- a/fs/bcachefs/mean_and_variance.h
+++ b/fs/bcachefs/mean_and_variance.h
@@ -17,7 +17,7 @@
  * Rust and rustc has issues with u128.
  */
 
-#if defined(__SIZEOF_INT128__) && defined(__KERNEL__)
+#if defined(__SIZEOF_INT128__) && defined(__KERNEL__) && !defined(CONFIG_PARISC)
 
 typedef struct {
 	unsigned __int128 v;

