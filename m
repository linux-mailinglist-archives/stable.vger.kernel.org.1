Return-Path: <stable+bounces-136655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DCA9BE39
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF497464795
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867D1581EE;
	Fri, 25 Apr 2025 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NPLuiZG9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F5CA6B
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560634; cv=none; b=F8NKvQqgNqyQzMIWlMsaYsRdENs12U4+THTzyFDL1hU7UgmAkWuaYMBJef9xJ0IOAya4LM94wCktU1lpVgXqj/qGqGzl6Bnt6A1ewlv7sLU8u6Ex+v+wW2Cq2jGr7LYW4spujvxL8avAGH3gii0yE1cPYopL42df9/3I6Y80wtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560634; c=relaxed/simple;
	bh=QpDGnApFPxIXV2DJmPdl3Bo1jIgnX6nT1Dn1m4qOqvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVkHVCPTb/hCk9sPM7vSgpM0SLYOGTUKBJVWJeBEtvMFd9SIaF22FK/fDos3vtdgXDQKVodyRh9b+3gD9MZd9IxR20xpQml6m4+AdfH4hx3UUAgYwAwHT7qxlPbMvZ0B8u2tM8gSijVe9IInV9ZPjQeDOA9m9hUTA42TVUlZZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NPLuiZG9; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39ac56756f6so1766749f8f.2
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745560629; x=1746165429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mbm9LvczDRL8dc4GtTm9KazhdL4X0MkglC7DkZSecU=;
        b=NPLuiZG9YDn3VR/mJ9lyKZgo1XXsS7qGyKdR1nYX28JEARJbxdNFilhd4di3nYDDND
         3TwgpihRhu9KShy5PkQaCB0dTcwExg7yV5xi4Ps8lZWbH0bsUBdp6iLAz/ZIQ2IGH4Xx
         c1HJaysOtHNNWvuFTfS5ltUiO/XSICUHYwQppdD735gskA/AD+y58eHqjrBuCN8rSSNL
         FvCMslMlEiw2o2YQiXTtC24EMXpv2cgvwMY67vp5oZud++DzDhr3KmFzYJQNV8KXybzk
         GVHoas0UYRTEn9GgwgFL9laNx+vwhAZKdwI0M8FaEfNR9DIsbuwoCZBfUOl81xLsFEar
         vzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745560629; x=1746165429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mbm9LvczDRL8dc4GtTm9KazhdL4X0MkglC7DkZSecU=;
        b=W59Qt4rw+xUqrToCZE6DBwnlIQtqkLMeWLlJxYmrvg53qD6i+No0JAu/in668qzhOM
         erlTXRzVQyXyiGR4uvcc1CwX8yqVlbT8VJQoLrijnqNTDocg7+hl8GUFzAwr89R1UmwU
         acbJRX2/g8ntFc2nB0vStjj7lXfIvxhIRKkew/wxExrRcBofiD2W+XiR3ku8tpWFS5oP
         g5eLoXJ9gkkFF1Fy52t7qCMOivatdquPlav3gTFI0RV92QbWS2l5n7FQ8m2qi+SsYDHR
         bHZRpLuIUtBuAV9bZdZD2FgQQVtxH+MEI3VCWaPWeNwlQvf4QzPWzSapqPafloSTMaIk
         VH0w==
X-Gm-Message-State: AOJu0YzJZfzooW6OK712AtXnaW9A0HdlafYd2d0wrWEtomN5qC5rEmF9
	W1g+JvVP2Ggh/8M2vAiDrkSBUWa8X+tu8OZ+EEAml2dgKATnk0OH3SfQvQYN5dsnM3DC/66s+vy
	9fv/d+w==
X-Gm-Gg: ASbGncuoHCB3lN2iiL4snqRGI2cyMrFNkcGT/cQQYE+3M4kXk0LXFC/zi5jPl7urS/y
	qxJDMUkJZAPGL9qZDfe7Dl+YY+5lFFuOHBqdV6LchzsLLCk7X4Ok7flX7IpEgFYARDrs3SRemcf
	lmDhaK0AliOdboQ2FQ+lEZ9zTJhJj1XKdCfPx6KxylZaPh26yWwX5nvf5PmxEAqBpPl5E7i30RF
	6lDg0k9PX/hsxrCrxWpuHKtZ+xigtpoR2CsCdYjDhWCCZm3F35SrvOxps2qtgEd/rK5RGr9xn72
	r8NQ//o5R86CGgMsv21wJ90hVFVUTljvagJog2SBtTo=
X-Google-Smtp-Source: AGHT+IFcOHEKiuoH78FXi02VyWeIK0zR1F7+Zug35mI3y4FXOqkNfrme4wrzOIP0l813kzZcdLud/w==
X-Received: by 2002:a5d:64a6:0:b0:39e:cbef:95a7 with SMTP id ffacd0b85a97d-3a074e1dd87mr571690f8f.18.1745560629475;
        Thu, 24 Apr 2025 22:57:09 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4db9b02sm23954205ad.56.2025.04.24.22.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 22:57:09 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Fri, 25 Apr 2025 13:57:01 +0800
Message-ID: <20250425055702.48973-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@linux.dev>

commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid.

Removing all the test code creates a conflict between bpf and
bpf-next, so for now only remove the offending assert [2].

The test will be removed later on bpf-next.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
[2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
[ shung-hsi.yu: needed because upstream commit 5071a1e606b3 ("net: tls:
explicitly disallow disconnect") is backported ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..0a99fd404f6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		goto close_cli;
 
 	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
-- 
2.49.0


