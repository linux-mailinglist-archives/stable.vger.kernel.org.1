Return-Path: <stable+bounces-139675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EEAA9224
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439863A747B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA11F7580;
	Mon,  5 May 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZLMuzeqa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D6202995
	for <stable@vger.kernel.org>; Mon,  5 May 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445018; cv=none; b=o4s/m2etkHlMMM0eHnnU11vtmbeXH+K8JJ2Ij3Jo9L5G1hn4B4ZGB8G0vJKWEeSlPaWJbYiWTFq1nAw0bJQLepTd082fsHsDFs3/IFdUT8ZDj0fi9Xry5n36QrTEwCWYMEpMdcMc/U18hdNBmh+AYZvekPtr2W+hUNDJaORlbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445018; c=relaxed/simple;
	bh=e8Jb2F4baybEF3ixCcwq5iC+KpYp2czCY5qV0nk4AiY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NMh9nGBiZYy+Z102AI4qhu1rAJNfThGEzTu25EBLf6jO9TMDkHegmofFoBq5EB0Ak9VwlMU7qVBFhUgdpsG+nQ7zDK9Mm4WJ6wz0mRrKKZLr9QSWDU18PBTxN8do3U6fGKqelecL8hDA7w8oAFuA9FAZ1JSBEjHGmTpAvFha9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZLMuzeqa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ace358c4d35so54974966b.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746445013; x=1747049813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8Jb2F4baybEF3ixCcwq5iC+KpYp2czCY5qV0nk4AiY=;
        b=ZLMuzeqaxoiplDU3pAtBxBSJ23z1LRX5PYsfhCvIi70IkNwRrK28fCpNTGCwGN7UWT
         AzwTsdmwtu55keDFQiyznF3C7dJ3ydKxza4X312hn8VoWSTz7Zm/o8KxaD/ca+i/Qdn9
         ivHqi6lRcfJEEB0rwled6DJWtsmD80bCbOOfCeXGUSxQoGo/HRwWC0a9x0cbPHbcBjOi
         sEHIQY5dZ3uxfbIPTaLd6zrEgpGk2EfSP1pBrPu1DR9VZQysm9GRNbOJW93IG2p8+CDx
         rgxJ9+qmkfoFUtmNdrWm9zXMwlP5HCJaGPPr4hJ4pGXYmn1KhfbrfSbGl3LboJxONpWn
         Rdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445013; x=1747049813;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8Jb2F4baybEF3ixCcwq5iC+KpYp2czCY5qV0nk4AiY=;
        b=N1NgfISdLtXYls0PkZworRx+uX0z6MJpflsV2XocuUaR7PMvIgSklQ6VHOLGsRmPG3
         sf/rFSiLRi/jyVheNNtALMU6zgmAdwSbj/9xaVm8eSfl9gLKs4+aj3OuZbIL3E5ltfI8
         fXBVIcOK7YFtGP7/tfnjcPBPpoINuyKhrc9ngMMuNsJC0PVjSlJtHbtcqciBISVRMbbH
         rs6o8I3Jpu6qauXF4u47W3ZqidF6xhp6ABWHmzfz+hL8o6zIUdjS8ehKB//57bfF7Avg
         H88okBvFgzJASNfKLFkIcurps1pJvFyL1gwEcqgUYvNeqEZU2/NTAmWyZLCsORdkc6Pn
         rctA==
X-Gm-Message-State: AOJu0YxJ6E3sPfegYRkbo1NQNMShahp9ACbpnoDhi2NZ4kzD72f17fKf
	15BfBrkkQHQ5TwQrXcPXLZy17Nl63qw+npeYolX8WvE0LZNBzbsBnlQ1diP/OQhZ52hGZ5+3aih
	KA2s=
X-Gm-Gg: ASbGnct0k2uvOVa+8MK7K8IPbJBTsUdTfT3bCTVQ/4H8BszMTWndwYPfpRl+PoqeGe+
	2ILzk0wvIZnMYi3TpI8/Gyef297KwwWhWtNeg0SX72RpU90W3ow5hAv3JTMAA029RurWaPJUvYo
	FOyjn5HBHpl8G0FxEq6aexIs4aaMkpS7fgYMLi0Me4N3JZKLkBP5CostKxXDLCIjhWhQ9VKuWfz
	0+m3YtNB9cgNG7SCp61V/T0PGqsNvlVp4H9ZO4pyjkC+Y/ceN9JSAa8xXXsMC91ZGtuEytSvEAQ
	y/WM1bmzhPuaMZZLZYPZvIRh1a1ORj8mhC9i4juJvIt8m0dMsIQyFy4CfQ7Gkmk=
X-Google-Smtp-Source: AGHT+IHC/SMvetQeENVCTlhELfLF3jt6XgWRUg2pAFWsa6P62k82mdz8HtThkW+rkfWqLOhIt9Re+Q==
X-Received: by 2002:a17:907:3e90:b0:acb:7de1:69f0 with SMTP id a640c23a62f3a-ad17ada8b81mr355093666b.6.1746445013513;
        Mon, 05 May 2025 04:36:53 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c0238sm481385866b.106.2025.05.05.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:36:53 -0700 (PDT)
Message-ID: <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
X-Google-Original-Message-ID: <2025050500-unchain-tricking-a90e@gregkh> (raw)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	Wang Yugui <wangyugui@e16-tech.com>
Cc: stable@vger.kernel.org,
	wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_map_hw_queues+0xcf/0xe0
Date: Mon,  5 May 2025 13:36:52 +0200
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025050500-unchain-tricking-a90e@gregkh>
References: <2025050500-unchain-tricking-a90e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

In linux-6.12.y, commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")
was pulled in as depandency, the fix a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
should have just used 1452e9b470c9 ("blk-mq: introduce blk_mq_map_hw_queues")
as Fixes, not the other conversion IMO.



