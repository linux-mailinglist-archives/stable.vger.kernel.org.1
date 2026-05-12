Return-Path: <stable+bounces-245570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNFgBLQrA2oR1QEAu9opvQ
	(envelope-from <stable+bounces-245570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:31:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76652138B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FDC346A3CF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84433C3787;
	Tue, 12 May 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jExI3swQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE93C2BA4
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591255; cv=none; b=UJXlcMQ0sUs7p1oQeU0N+ri+5pBs4amKuAkxFO7wB6EXso7Wr9rElFntuZR/dP++VY+3lwLNhlyhGrSxYNabGuzjAmlQpMBYxvY8g4KvnHlk1G3wJ/KCnnojlJz2mSnHrQcXWRs91KrBdnqdB2oBPOj/fAM7ZzreOlympEcMHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591255; c=relaxed/simple;
	bh=052JeFXhre6eO/VYITYmvVypNbYdkagBvVoKDgWy/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Phh6l2ZLzQ8aOoa4GoLUzi36tzs+C4ffDZ3zauOjlGqoT1bSrtiF3nw1zGjBGPPGtXM2kKqfM9YFoN62HO1gZgwbypUK3z6oqvuqIPBS65rw+cLa+AGDqLp6oQ36RMYjKd3bRSjkDYpwUUscYsgzB3u3tzmE+ce/cPvVe1ijK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jExI3swQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd810cdc5dso58491777b3.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591253; x=1779196053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nxlr/Fuo3DPIglH7by58rq3oaK6PaKeNC/vr3JaVbs=;
        b=jExI3swQ8wa73J3X7tEPqmlPc7KkYi2RqOJAt/Jn/xigzQ2STrx9Qk3hJLPb3sPSn7
         hRU452HMLvS8kcefuO+wg5FVTOzfCYbcMJJaZYQn84E3bvDK0uAO0mdSnZhlv7APMLVO
         nH1bf8P/6E0cxASNhS5Ba2MoM2siiTksjzFgV/NQMYQWDqZ4OsySXBjKa39j5X6U5A/e
         uzbkBtGwnwgteW4wu3D7SkHzwItlivZCTwSdLs/HUX+raPPs/UZz/nNhqvaJEiNxwzWo
         safnWN3lzojdTkS18t8ea+6e47q1Hhg58EavQQJKEDkO9L4gcPs5K7j9LA0DHkovgtTM
         1VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591253; x=1779196053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nxlr/Fuo3DPIglH7by58rq3oaK6PaKeNC/vr3JaVbs=;
        b=QFBCQcBvZ8ZYaTTaaxUvJ+LqyqOm68fiVBgPrkfExHrL1vbk8L7H/bLzlh4jWDs2FR
         acb/RF+c6kpeZxDMHC4ZoilGsmWm4I2b1cYOPHAESMp8uOHpBUlj638pP4n0JOmIj6Jq
         yxKQ6H90FOz0j11r3LLm+diyVMIQutOMnVUtkHGe5f0M8pP1HjI6wFCb1mIpqhNZSCRy
         MZ1Q2AJ9kVXYGZqPAmBqNH2ZfXlg5mybegMvk6+XdMjJ8sW2wihsLbRbYWHv8Vz7Lci5
         qF7MO2qXQ7uT4CQN1wnMNdyNKKMcx7eIP8LR5LV9x08yv1BenMtrMR6PLsRSOTInBKgx
         9bhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xJUiyrIc62RWGFEmsIQ8DcZ/N2wptPgIi8SN3yuoDlIeFoZQW3JY5dMjA/U4AJ5PzhA6wBp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTgpLsaMifww+I8N16NRMJCStuMQd0XwYWgeZY/YCGie+KsVz
	qisWhJOgVSQp4MQ5ciW90QDDnlVTYDdbut4ejMQNvdU6FWQpuboj5oG5
X-Gm-Gg: Acq92OHvrIz5+AY4RYPF91ccvQ9alrWI6+8Hc+ybqaE/dll4zSXzVkjjvKrWIwd7JZy
	qFPhWNufoNJZWhGsKIAEy5E8cIsEgouRj17XC38HxJFtqYsbxraz7bWKOq4G8yTI5kUPFpmsuTJ
	WFZFRJrT3Se2a5C7X1/vgl0KQ/jlGJJIMgjGo61hvmPGkznN0Ssp9snGmME2MxsEubB5FZNCpGE
	3K8ZpZ6J2EHkmHM8M+gmZdkzq0MKndqGH+pI6FzHtly3ae8Ofh2VanItJrP33eUEHjBXJEJ2uDu
	rnqyJCaefuHqTYLYMEVecCR91dz8AogflPbxEGEimYakO9AnzXxb9ksCB4VblGgwACvwQTjoMJd
	TaSpZSnNiIEMEFGMW6OWFdiug5yPpv2Yoc6Pjfh9QCO+dhsIH333dePJrXHKHDqet/k0BvJkEnM
	TPssXu+kW+SUGzfsnPYgd2DhK6L3qEQK8smdyYpVEucRujW7wNKOsKR3fH
X-Received: by 2002:a05:690c:88b:b0:79a:daf7:c4fb with SMTP id 00721157ae682-7c564333efcmr23522777b3.50.1778591253072;
        Tue, 12 May 2026 06:07:33 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:32 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Tue, 12 May 2026 07:07:10 -0600
Message-ID: <20260512130710.933089-4-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512130710.933089-1-sebasjosue84@gmail.com>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E76652138B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245570-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is always large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be resolved
by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Drop redundant count check since initial_header_size = 71 already
    guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Suggested by Xu Yilun.
---
 drivers/fpga/microchip-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea86..cc8f6d7bb 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,6 +116,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0


