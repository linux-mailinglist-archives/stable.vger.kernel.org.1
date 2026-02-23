Return-Path: <stable+bounces-217800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOPbAiaNnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:23:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADAF17ABBA
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F293005E97
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD7330D5E;
	Mon, 23 Feb 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="JIijhrFY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED3757EA
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867424; cv=none; b=R4y3JEZesMV5YPB8MApf6rOD5+qj4JC7AruDylHa+2g9uf0kImwXpW+zWJI/nLtC7mTFJT7FLY68vjLvxC8+1ZgAr5pl5YablhSs+0rldrDNPshAik652BbbQ7mzuWGRMroR4NFBHzl3iS5A2Whxyvh7D2NSTgJAcbkSCLwE1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867424; c=relaxed/simple;
	bh=q2d2B7NOSbKwb1daq6f09bsl3AuwgAOy1kmDKG/CQDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYyySs2eSJ95hlMCGnRKlj6n0in7lR7pou9icQcvJQHJFBJRynmo6yKP5za+l+pzefQJgxlrU5Kx2Q135fUzWWMolyt9NjMQEaGVLy/ywsYHR27409RiyA81iv2Ymey8W3/QXUfTYfdrSH1H9pOeTzSGV9Hv3OvpcleipIbA0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=JIijhrFY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823081bb15fso2763445b3a.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867423; x=1772472223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgu324w0HIHlwSK2I3DaMKCWs94NR4my1xNx4FGWhRc=;
        b=JIijhrFYsfOhujPjSdKGs0D2XcLQXgZxoNuRp71taPhGHwDzijI2l0S4icqEHvjx6N
         ofqEODdMKR8avIdqHS3ELg+F9O+gUQehvyQ9OMqJF5E52IPFVpbY/wJJ2OXwIFd/mLFo
         fVC+DxS595Ng80l8A+AB867RTC1rC8gu/Au1tMD0bUeH150BaWKn/E0D+gyCxQSjcGSW
         cx4+ptJMBhLw3zX5Ir4K0oic/tFPv8xXmJz1bZHJaDBC9tffHmUgeC6syHRjqSRZIFr+
         Y1JlbgNdlPeXiYqNEDTCQNvk4rpGITqkDRkaoOaW01Ii9PrTdD11ftzQVpuBjMHneF+O
         5p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867423; x=1772472223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgu324w0HIHlwSK2I3DaMKCWs94NR4my1xNx4FGWhRc=;
        b=ayxk0vZBndT1DRJdhGD9AwjXbLs6G/SZ6NcwbPRRHx0sNHLJFTvVk2Lr2pv4je5NuC
         eYEiQa5x9SwJ2pTJpfO6KeBa0ZiN93PGc+rEiqtyQPl4twTn31UA1bJ2PeRs91Hb0IbL
         Q/Dq4IqMEpT0KhvuIv/LY0v3LkP/aWf7xE4JuHdiec0nKeilrvUMILjGTL1VkVfjM8gs
         1qD5LqrbojOCo+BULffTKGIxrp8L8OAdBSuRwWn7T+dERLLyWib0q/M0ui/zcA4IqVel
         Shdrc4PS7qBys7oniSIzQlKBBGLeeWrgHhQz4mllqdgME+BUJXclSVnF7E6mwrs34kMP
         wOXA==
X-Gm-Message-State: AOJu0Yw8w/2xXf9u6DRdilddJZrRU1qQ4ROwF8OwekevEZqPVQE4xEQG
	2MbTyb2i1bnNyOMSYKfSEcy3jLrHfJPIlgadNIqZWj3dlkMienmNyjFyxu1OJQzyzrokt6Yo42d
	8F++C
X-Gm-Gg: AZuq6aKfBCWr0CW5pqdii2kcSCzB0RfwOf2vFefSOetmPNS03yRcY3zHTaVbfjvDYE+
	aiDii/daZs5dpN9adTadGbTJAA12JASmc5uRUcgluQoyYhVP1ANbegTrPSUl4sOfx1ku9iI7KQf
	JX3RBp4s5Ygm3lyybymCwJ9nxoC7ssLyfzrGH7acrpL5r8YkwT4nbWXqq7InRbi/3BxYxS6n8+w
	i02tNevtWWNdGzni4OOBrXJiGduPd5awmZeF6feEx+1RjhGhHifhJwdEcjFNAzx7zKwFG/xVM81
	+ohgSYiG0kVHO/LaIyEqtiE1/seljF4tTDR9EWePkX9FFf3cp/ALMfgHt8Xa2rPD6MyFWj+gY4w
	7IQaa9FCJ8F2KE4lxpmWk29i4fVdxNslvlYbkm1//COLw0YvLTnK8gvioxu7KjGyefAN3ZOc4ET
	5zV83LDzRLa/aHbenFTL2BkXXym5gWLY0=
X-Received: by 2002:a05:6a00:4f8f:b0:823:786:1990 with SMTP id d2e1a72fcca58-826da908495mr8069057b3a.21.1771867422928;
        Mon, 23 Feb 2026 09:23:42 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641313sm7876162b3a.1.2026.02.23.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:23:42 -0800 (PST)
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
Subject: [PATCH 5.15.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:53:30 +0530
Message-Id: <20260223172332.291881-1-jsingh@cloudlinux.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217800-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudlinux.com:mid,cloudlinux.com:dkim]
X-Rspamd-Queue-Id: 7ADAF17ABBA
X-Rspamd-Action: no action

The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.15.y
was incorrectly applied as commit 60ba31330faf.

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


