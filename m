Return-Path: <stable+bounces-192993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11250C4962B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 22:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFEE188CC90
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52682FD7B2;
	Mon, 10 Nov 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIEZalwM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01212FDC40
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809624; cv=none; b=TXchzNOqXGOVDBXTGYkNXIL+asHTKxLLWpa0tR0WMLDYePyu2guJoWXr0dYvbY1sqzUN0N4goUPGkIeomJBi9j5Sn3ufu3nASzmXJM0R/x24Cjh+gbFHKKAHbPXkqGI3kfJxDd4qx+KenAueYUEIS5nKe3wf7EIMdj3vUM++o6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809624; c=relaxed/simple;
	bh=JADbXZ5UI8Umt97CJUolaWnIg4Woa+TeJ+k8vFvZs9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2jSK3uNTNzmKK1YQh1LBD7LEzYjVwvX9WlM3wQ8/oyYhW2jn+vwb1VpXHyWdbAnW2Ai6riCAOpuzPGBGL3YrH/GoA6fTZKH0wVoYETHA2AvtlY2TUL+NymeZW4YibO/wnEjEJwgaO0vI9K5GCmZDIuaXIOqZKATWQDb7RtBSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIEZalwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762809613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwkRbSaRWjLN0bjmCmxaA8r5XkXC44OYSeuiWIjvBBw=;
	b=AIEZalwMnNiPbSMTpibyxmdzJmOE0F7Ctcxtph8JN+bUOqLpOaSjDtokNVd14BMrGi6M3g
	L1iKEuPLAPa6FXahU/Gb8Lx83vPplsCROzCXbfYuaFdysR7BYmpzHPjr3EgkP8yLeBEYwG
	yJhF5974iNHLaKvFGUjso+p3Z9PXaTY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-ze_qOA5lOnGL22DR3cL4MQ-1; Mon,
 10 Nov 2025 16:20:10 -0500
X-MC-Unique: ze_qOA5lOnGL22DR3cL4MQ-1
X-Mimecast-MFC-AGG-ID: ze_qOA5lOnGL22DR3cL4MQ_1762809609
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AB041956070;
	Mon, 10 Nov 2025 21:20:08 +0000 (UTC)
Received: from emilne-na.westford.csb (unknown [10.45.224.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95D1519560B7;
	Mon, 10 Nov 2025 21:20:03 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com,
	james.smart@broadcom.com,
	paul.ely@broadcom.com,
	justin.tee@broadcom.com,
	sagi@grimberg.me,
	njavali@marvell.com,
	ming.lei@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 0/2] Two NVMe/FC bug fixes for -stable
Date: Mon, 10 Nov 2025 16:19:59 -0500
Message-ID: <20251110212001.6318-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch series contains two fixes to the NVMe/FC transport code.

The first one fixes a problem where we prematurely free the tagset
based on an observation and a fix originally proposed by Ming Lei,
with a further modification based on more extensive testing.

The second one fixes a problem where we sometimes still had a
workqueue item queued when we freed the nvme_fc_ctrl.

Because both patches touch the same nvme_fc_delete_ctrl() function,
they have to be applied in the correct order to merge cleanly.
However they fix separate issues.

Ewan D. Milne (2):
  nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in
    nvme_fc_delete_ctrl()

 drivers/nvme/host/fc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0


