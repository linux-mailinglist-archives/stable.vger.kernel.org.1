Return-Path: <stable+bounces-217797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFDbBZaOnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:29:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7817AD65
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C846D30FEE76
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006F6331217;
	Mon, 23 Feb 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="Ej/gVug5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFD329C60
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867371; cv=none; b=sTKNMVr4u1Mu96CCehFw7hIViFHK2rQGzniCj4GPOW1fZbd5smbpZwrD2pncL9erCfP5vANq95NOtXDXN2ShcLBASrst5vp3UT7wQxaAJr+MKB3rjxvtPDYJpSpnstxD/UMRrX4Y4YA9DZMcI9Kmrww+mJ28rtm9/Tqdym+u/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867371; c=relaxed/simple;
	bh=GsdWTmHfrACFFCRPfF/itkGs3OnYV74Af92jjZQ9U54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEysFlc76V2ReK+XpIOja9zU6m1thcR24whnByBGpDfMQdnLaDOLDz8u/jaFId7xAZQxOiFBa7/7ZyMQ0W0fZWcxY4Itq1rVYjI/Qo2Y54fpK313TEps/O827GjhOmia6I0+T4EOvG/KEb0swOcNIRsuKEkcCDL921cMv7F97gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=Ej/gVug5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso2670134b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867370; x=1772472170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zl7Z+OaO89snmKUAHrxKVDI5oM0jK/483ZZ+xANRJw=;
        b=Ej/gVug5TKN+EIOLMKH9J37NucO3yyl6ElKL7o18x0pSXBhZCooPAUFKx/wH7Qp79O
         nZJHVxwMm4k4emif9FhHhzMfE1fq+hCV9Vosb0sd0KmC9tpgMadlIdDMnTpvbjQmzz6x
         TmuFZPpjqNA90IymZ56Z7Qq58pO795kwhxa/V4Z8zs7dSaxrAC2pB6Hr4OYO5k62kHbZ
         aIFCAyjpMG4cJ7VyBo5x2VAGqkpUrPwLBn2PfdedOO/U4/y7g95py/elU307W+G65M28
         m3mnv7jIdB1EZeDjrGJRyTijV3+gAo0TjzKYHnq38RZGqxSlHQab/eBof6aHxqEGnWTa
         niUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867370; x=1772472170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zl7Z+OaO89snmKUAHrxKVDI5oM0jK/483ZZ+xANRJw=;
        b=N5JD6uuvNBsnHMgcHD7pH+5yF/xZVU7kYJOyhh18xZsJVtGVt/71ubDHZ0gINYb/Y/
         1ILhkem19bm1iZrnwUqFEh+R9AP3Sl6f+5fzuDGl0Za5HMlS7kTR8ax9oOlXtSvs3T3n
         CVyo64PHvrBE+EN9MSM8BEIFZI6nbV31X7UEnCi2sy7aJY+LnSGlf4Y0xCVvnPVGSVpn
         eWhGnLRbZe+W459nlcj3aNEF4KeifXGWDH76tTf8vOTMkYdNkPlvM6TkYRt8E0rIbogN
         ooBjun/VKobEORe7UkfPkQVnuY7UpTwSAbEo0QQXK5KrDsqUXMHen6HSDBpGWI73Po0m
         k5xA==
X-Gm-Message-State: AOJu0YzZWZXh4VQbdimuS7tui2fHmmoyxgEARX7jTr0jRyS3CpnzADUJ
	AC6m4MqCzuTFNiw1w6S3kK/JeX06KbGMGOCCDGI3MF2GOuvKQPUtmmaJOfR7GsM1Qu+NN9G1jhk
	j17n+
X-Gm-Gg: AZuq6aLl475nT+ZvcO3hK81WE1aa+Tr0vCSzw81LfXNwg4qE/zWFF2hPsK9PRaXv8rO
	ZlwAOfxYEXeJW+milCSl03pFy3Ot6R9ErQYhJXbvvT0OUaHLOZmIOWrW5c7OTKKu1vJFx7WqOHr
	gVB8dKEkU6may6Uq2b3juL1vv3V3oC49tdreALH3b1QXXBzAqQyjRunfs+r3JytzqLnETUOI0H8
	osFXxRPwzWcEhTJ3tZ6O5Y9HsmAeE6mitEpldnm00mFMKuje69Txuny+E01GqwoyD2jvlX74fnW
	5dtv08qLjC6WXDMrtYW1KCmWQAT1qNeYXAZdA1ZJ03WzLNSImoG4S73ZNyoNtTSpJUsttUBhLrD
	BSrOe0Sh2+escxj19BFz3x8vo0dOsuNg8GarI8jeZmknyEYmtdW67nDGAEt/qEs7WJL+LXjNZiJ
	kYRq0BLsrYQk6YA9Iydl7cGFsK8NBFy24=
X-Received: by 2002:a05:6a21:512:b0:38b:e750:bc31 with SMTP id adf61e73a8af0-39545eeb17fmr7900675637.32.1771867369604;
        Mon, 23 Feb 2026 09:22:49 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7269771sm7942918a12.30.2026.02.23.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:22:49 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>
Subject: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:52:39 +0530
Message-Id: <20260223172241.291649-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudlinux.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217797-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim]
X-Rspamd-Queue-Id: 69E7817AD65
X-Rspamd-Action: no action

The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.10.y
was incorrectly applied as commit 3d78e8e01251.

The original upstream fix moves the cancel_work_sync(&ctrl->ioerr_work)
call within nvme_fc_delete_ctrl() to after nvme_fc_delete_association(),
so that ->ioerr_work is not running when the nvme_fc_ctrl object is
freed. However, the stable backport mistakenly placed the
cancel_work_sync() call in nvme_fc_reset_ctrl_work() instead of
nvme_fc_delete_ctrl(), leaving the original bug unfixed while
introducing an unnecessary change to the reset path.

This series reverts the broken backport and then applies the fix
correctly.

Jaskaran Singh (2):
  Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()"
  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.7


