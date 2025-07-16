Return-Path: <stable+bounces-163122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E66B0746C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226AF188F6B7
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E42EE980;
	Wed, 16 Jul 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2uzZtRy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61172F3C06;
	Wed, 16 Jul 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664514; cv=none; b=faSsY5O4IWwiUEbuwKbrPok5U1kdkJYxb706VyCqNa5Foivz3peG1L79DpUZqshk1mB0rYSB5i/PC+Kx5xmQ+9ughTb3fGT3n1fnuOUKbRYzxNHm5A6uMFMoty4pxnAxrI//+ff7LrqWYSYxBXW4dMHWoZQEUVylwiMwepa0b1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664514; c=relaxed/simple;
	bh=ZZHzJrWOk+RMY1TFTceSwgs7ZgfIW6BIo+VUDmdSqf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WdWP5H5A+x1J7cySb1FnCovnonRobIDlPQwrwAn+VGf17Is/9AZMZEYTRZn0Rm0FqcIrxyLL0d811PAo7p12DOIt3zY3qVkJH3/nTrKHD7K6xs1hck1SKxm7yoLRnhI/Chd2DGqPiqeYBzxRQ1IuAIUyl6skpja9f2ORTzwqoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2uzZtRy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so9945534a12.0;
        Wed, 16 Jul 2025 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664511; x=1753269311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=io7xnfs7ZwmTYZN/t/zWcB1a+2GG4fTJlMUwgJIzIWk=;
        b=H2uzZtRysp5oZ0Q6vdE52omP2HO18DPIrW+/lBvdK7volWRg5JyJ1qBzF+lnk+IzVo
         FtNKw2NYzOwYCIh0XMBK5VoAkiF9BoQ8xR75TsJ6lyRh/cR8Kjl394n0IHT3YQv0Yi4c
         3bozlenil0ej9xZpsDc5B0TXVZDJB9G5c3soeP+1LEgbRFLIcbIMMOIEgSXMYvF15klY
         kQSBeET0ODgM3eqLlsw7WlrnwO0u9AHnL5gh/aXIe33kPEPKHrB5mhFoPTYhGVVfJaS6
         kZGi8tvAitTooE9nFidT947goiFJgBkipCgqZtDwJkplYbxFNsZ1NPZLdV+FVfOnNu3Z
         wI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664511; x=1753269311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io7xnfs7ZwmTYZN/t/zWcB1a+2GG4fTJlMUwgJIzIWk=;
        b=hZ8WjoyjUp5+9DDYoFCrqhyhUovixixiwk+XkB5si+StT5GlGeFOtkcNk2JuCLaopC
         JdIV/4O/uEtA9wa5ADT8Hk7t8IVR1gX9cU/vw2+a24ILH2zYmYAMiBX+VJc5WQHEPN0I
         OufFdkbPMMZbm/0SKmnMRvr6mO/zfto0+jMfRFT997TZuuhcNLbmKBW9BODuS94kC3Zh
         39eRh1YAifoRVrfTaIIaO1SyTYgPOP2pk1scMZ4MVP39Tl88fIKcKiBpy94181A3vYBf
         mAmsS5cCt6AGXElBDhTVe0Ufp4YEdSVttWUdmOiDVbLT4+hHGa30miYaYWOkm6Hjr9z0
         p91w==
X-Forwarded-Encrypted: i=1; AJvYcCUmmz87Fe068cp8CIGbSDI1BPh2aEdooVVC63FKNR4hVD/EVD48zstApMruSa9y1CmYLMP07fD1t2Jylys=@vger.kernel.org, AJvYcCVdLwHTauYXc0T0Wp6EcQhRlfu7+u6UeXiTJICZpM0MFOLRwkYT4YDI5wZjB6uJI45DecEt/DA8@vger.kernel.org
X-Gm-Message-State: AOJu0YzQltjnhZtjm7/+hXkyML1hFazJ24yWdLtkdigoa9bnjoj2mE0a
	SqXWqPKi+SUeyueMe1+EcQESGjw++7xNZbFnscLDBo2OvUaKqfQwUZMn
X-Gm-Gg: ASbGncsjolWNXozMt4faTe2oRGcQKxndoGwsjRQA9dZvzymgl+SfaRqWGLN2JCKolS3
	mr9e6skSt59i0ukBlYJHuiluwl6RxmRJQYJqwlzYjLhU+pTGp1UxtchNsFtQfpqN8CeQ/5slbaj
	AJFGgjmMoMxBdUT46ScdDXlB6plvjqDZIwNnUiVS8F+P4n3xZ/Ppa1kdDqhmvOTRpY62VitXEFl
	DKu0OSOxkL18Y+V4asZzqayjAJGxiypwDKm3b+VGsdnO7U+cgCQP7kJnNPscRqtZj6/fm1C8av9
	aU1lOzsHsI4cg9mumbLuNb+SMpGa4BkPAEZkVi/DlVfYmyUwWk9M7XqxXvbRW9/l1eiqN4YQTM2
	4YBFyPsCV+KEKfvwgyDRHd1FhbmzKEs2td+0fmDgf3fm53I8O
X-Google-Smtp-Source: AGHT+IGlmJIjo/68lHst/glRTYFQLAFf12jb+hMUf8o3uOa+2mrtHC9N9zXMrTgPAT+9voLRv5rVoA==
X-Received: by 2002:a17:907:6d11:b0:ae7:fc3:919d with SMTP id a640c23a62f3a-ae9cde595a2mr241914066b.25.1752664510574;
        Wed, 16 Jul 2025 04:15:10 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dee16sm1175217766b.152.2025.07.16.04.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:15:10 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Wed, 16 Jul 2025 13:15:02 +0200
Message-Id: <20250716111503.26054-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1 :

- Updated comment for nvmet_pci_epf_queue_response() per Damien's suggestion.
- Fixed typo in commit message.
- Added 3 tags in commit message:
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org

Best regards,
Rick

Rick Wertenbroek (1):
  nvmet: pci-epf: Do not complete commands twice if nvmet_req_init()
    fails

 drivers/nvme/target/pci-epf.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.25.1


