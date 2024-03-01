Return-Path: <stable+bounces-25749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D686E3AF
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9081F2532C
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7F38DC3;
	Fri,  1 Mar 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kG7feM5K"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B76EB4C
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304322; cv=none; b=IWLWj60nFulAE5jnWxSphuH3vXi2zxH7TvBGnGIey0qQ2BnNSUfHG2mkcnBC4XZDKzwD7266fGzKnMWS8bYSkWzmxVDrYm53tQiV8iWv2piphJaQt+ZGv6+/+RvDjC4djptkMjDPRXob9SNOMZFjbYrW2wPdq4yHsd2uLYdQYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304322; c=relaxed/simple;
	bh=pbeGoTrS6YnV5hrTovkgSHfnq+aGXzRi2Qk5uXMxLv0=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=FIeTDuZTs5n33BFeLrtSpjcQ8sG6AgF0DB2bkqo5qa6xG9SZ61pRGzsIB3wuZ5Y+fT3HvuzDJINI1nvN5nkvg3A35QtPHqDqkL9IhusAm5waHlIouYAi/jc3Sp3z8iJrcssFLH2+h8VsNSVerWbndCYJWEG+fgP11CltGRB/JBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kG7feM5K; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TmW8k4qp2z9t4g
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 15:45:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1709304310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=iJCp30pqblMWh0x8d35VWAYtZu9bQxAsYfhcFpjjCvo=;
	b=kG7feM5Kk1SVDiVnYDBPe1Pej9U9g3D3XrYs3C77piFcYbTKOJ63xyhSgeAWfowpVpRw1j
	kFeatlVknlGA37+Z7KDm1fSos3GgIrc9iJ2i6IhR35vA49hN0JYwO8odHZYADwzVy8+kpl
	xW35euoe2c3Vb+36H9zv0QphV16/FDV2IwzU9S6uHphKi7h0QCP6S0g87WHlx5n7G1PIuM
	cNfbAiErAjgWIphwF0uw4gHj/Jqc2cR2zUVl8DCzLis85QaDOOcKfEgjutMe8eLuK0ekLi
	1hZhewT50/e4yZ7d1fAKQxRyHynjadR2+F3XdMOOfdvu8QLgxSvcO9SBYtRFOA==
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Rainer Fiebig <jrf@mailbox.org>
Subject: 6.6.19 won't compile with " [*] Compile the kernel with warnings as
 errors"
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <339c80e4-66bc-818d-89c2-2e89cb41c4b7@mailbox.org>
Date: Fri, 1 Mar 2024 15:42:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: csxsn8iznot13thie7f5j7qd8tinkxjw
X-MBO-RS-ID: d0a4ee0851ad7850fca

The problem seems to be in fs/ntfs3/frecord.c.  Original messages were
in German, so here's my translation (original at the end of the post):

[...]
  CC      lib/zstd/common/zstd_common.o
  CC      arch/x86/kernel/cpu/feat_ctl.o
fs/ntfs3/frecord.c: In Funktion »ni_read_frame«:
fs/ntfs3/frecord.c:2460:16: Error: variable >>i_size<< is not used"
[-Werror=unused-variable]
 2460 |         loff_t i_size = i_size_read(&ni->vfs_inode);
      |                ^~~~~~
  AR      lib/zstd/built-in.a
[...]
cc1: All warnings are treated as errors
make[4]: *** [scripts/Makefile.build:243: fs/ntfs3/frecord.o] error 1
make[3]: *** [scripts/Makefile.build:480: fs/ntfs3] error 2
make[3]: *** Waiting for not yet finished processes....
[...]

Let me know if you need further information.  Thanks.

Rainer


--
Original messages:
[...]
  CC      lib/zstd/common/zstd_common.o
  CC      arch/x86/kernel/cpu/feat_ctl.o
fs/ntfs3/frecord.c: In Funktion »ni_read_frame«:
fs/ntfs3/frecord.c:2460:16: Fehler: Variable »i_size« wird nicht
verwendet [-Werror=unused-variable]
 2460 |         loff_t i_size = i_size_read(&ni->vfs_inode);
      |                ^~~~~~
  AR      lib/zstd/built-in.a
  CC      lib/bug.o
  CC      fs/udf/inode.o
  CC      arch/x86/kernel/cpu/intel.o
  CC      arch/x86/kernel/process_64.o
  CC      kernel/events/callchain.o
  CC      lib/buildid.o
cc1: Alle Warnungen werden als Fehler behandelt
make[4]: *** [scripts/Makefile.build:243: fs/ntfs3/frecord.o] Fehler 1
make[3]: *** [scripts/Makefile.build:480: fs/ntfs3] Fehler 2
make[3]: *** Es wird auf noch nicht beendete Prozesse gewartet....
  CC      kernel/events/hw_breakpoint.o
  CC      lib/clz_tab.o
  CC      lib/cmdline.o
  CC      fs/udf/lowlevel.o
[...]




-- 
The truth always turns out to be simpler than you thought.
Richard Feynman

