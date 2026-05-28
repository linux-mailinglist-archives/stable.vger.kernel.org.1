Return-Path: <stable+bounces-256432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5UIabDGGp4nAgAu9opvQ
	(envelope-from <stable+bounces-256432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6D5FB0C9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C220030DFD12
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F0368D6F;
	Thu, 28 May 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wipSqzZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD7363C61
	for <stable@vger.kernel.org>; Thu, 28 May 2026 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007518; cv=none; b=GJVsb+PCAWuCFmk/aHYb2zXGH1HS+PPhwUSNVT6g3m6WCYOoNE8rJN4VmvEqeXQG+N27dVh9oi0Wu76VAyIn+1FVJ2rj+AK9OXmo4tNQaWxgDnwWpEuBa046ZgtC6k9qZO4g7BbJFILhsk8lfmq48ESb/TUeI3ZAFjK8Wpdf+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007518; c=relaxed/simple;
	bh=fewyrO7jRSDRezpROiazTrcQjh82K+907ZqYYNd/aeo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gdgAe13oh98TUQAAGU+rxxVgkzfi7YTCcUZgyn27p2+hoTjpn1NJVFep2fKUHmjekfbNrO83nzku+a/S7CmRK76iF15JFwaYz2mzTCOeI54Wjzo99NVMkkmujiq/BMvgphzV7of0dqvZxlW1kjmzviJNHPqMTAW4lDrZodZDOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wipSqzZZ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ba38f45dso2625111eec.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780007515; x=1780612315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lA9n52XOp29AfkFZf1NgzFL5E2eupZtzE4Xy3Kjuzc8=;
        b=wipSqzZZfcSL3WPWJ5qWrgqOwxdbkFhxlhqmJ8AAj0tT0oYJZl00RU4SFedw3F/P/O
         FyD/+OGDFZrVhZpNlfiTz+lGMmS5QJbiDRyZXAaWkiC8R5kAKprWw4oQ9vI2Ole4BUro
         P8NGPcJw0JLvsxjQR9NxWfJaclegMb1DmkjC1Nc7mwJU3XGRwCJeRO38Sa2o1xrywxnB
         NWLhJaSVikqhCf8sSUM0RDjmLX/s8Mj0FZE4lbZJ6WjurPRaWRrZd9+aP3KNK8aqNXjg
         D/oeFFusvnZXx/khrHD/YiDS6wp78OwWyu0ir98r72gT6CGXyJ6gShXuPdv/WVAURQCk
         t7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007515; x=1780612315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA9n52XOp29AfkFZf1NgzFL5E2eupZtzE4Xy3Kjuzc8=;
        b=bLljVJw8Kh1H31azNDQcE9OVlBI8tiV9Y9iyJrM8jPnMXstH36gw4oQMTJezazV+zI
         BV7vCi8DYf5YuDxnFH4iW8xS35irzxF4HiGHqpxWPNu4Ku2ts1ONsgSy1m9APLww2QZp
         JrWXCm2yxFH6nEr095xE50i0rpqfOGc6vH0NMJdTp8vmYC3JArCqqXNaFPQxpMTHT8az
         u1lSRUmfZCgoahJrSLXmG9bX/HvNlNImpGXCZIABkOTxp304SnMx4lGJ6TuUPbmWlS4I
         KPYOzFCg+bxKfXTum8OVT/k04cewjoidttTLL6e/VTmUERS1Lck7RQt+aMq/y+XvubfV
         dbyA==
X-Forwarded-Encrypted: i=1; AFNElJ99fALwAGkxYIVnr0dhvyt6rB8mJBs/jfXEQQjTeTYlbfx5DZ4YRI9I8vgHjL0Yi6JNdZ8CP9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuKL1jfauNE1LyLQFXm6wFeKhBNxflqxtKPxc8iT72dwxIPQl
	WPxuuuLdJ8Qi/9LYEYjwMoiwabna1BRtD1dfPvzxx3/66NLtYjMPdoc9gJYIJLXLDdCm2MZYjQ8
	nRw==
X-Received: from dyx4.prod.google.com ([2002:a05:693c:8204:b0:304:eb73:cff1])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7f9f:b0:2f2:6dde:df50
 with SMTP id 5a478bee46e88-304eb0d30ffmr188430eec.17.1780007515107; Thu, 28
 May 2026 15:31:55 -0700 (PDT)
Date: Thu, 28 May 2026 22:31:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528223147.750229-1-wnliu@google.com>
Subject: [PATCH v2 0/1] Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com
Cc: will@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, santosh.shukla@amd.com, 
	chrisl@kernel.org, josef@toxicpanda.com, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256432-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wnliu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBF6D5FB0C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is a respin of Josef Bacik's original work[1] to fix the
performance issues and soft lockups in the AMD IOMMU driver when running
within a VM. I am taking over the respin as Josef currently has limited
time for this

[1]:https://lore.kernel.org/linux-iommu/ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com

Changes in v2:
* Update the patch according to comments of v1

Weinan Liu (1):
  iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog


