Return-Path: <stable+bounces-217803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC1JFGWNnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:24:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B875717ABFE
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96709302DE0A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAE33121E;
	Mon, 23 Feb 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="LxIonKmV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81432F76D
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867454; cv=none; b=Nodp2CqcAj5U25EGv6p91GXkgtbuT4nRbOgeVJbzWDPXiG5OD7gNIEJC3Xm5cvSmBSulWzBC22YOKUIw+azooRmysB3wkzySP08PA9CvrFs3MYNRSIdaubH6cIK9dEPV93RfINbusM60H2gg8xIDtNgD2tp7arZOG0+fQ1y/emQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867454; c=relaxed/simple;
	bh=KkeQ1/s4BX5VIB5xdzhL2dO3/TZoda7IcL/luhmOcC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCLzDcoG695m5N5ZDoHkPk2+tZU62uKmUlWoFUu96K5Swyr9o0NuU1F0XP17q20BJ+lVICuoHVoSWHcyxapXghdxQZ3/VHPezsN7PxTb+d2wxCA96vRsWHpHc6/piVo4bwXjlBZAK0dG0yF/KERM8/gsrFONyqUhSVbRgX7kQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=LxIonKmV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8249aca0affso2385013b3a.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867453; x=1772472253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvVS//J2RIviT1EM5PNeofKo+JkNGh+uX8BdQ0DJA+0=;
        b=LxIonKmVUJeoDTRoWq3yT41LHkc2wBZ+hU0ANbJumeTIvN8QmTEJeGbhHSKwITlDPB
         EAC1rAQSVDf6GDGPQi9Astiq4D1CvivkFO1RISH43vRJ11nobbdr8tOd9hmQV3ScFcd/
         Co5/KRHoULdUhfkBS087iKQbb6qGpcHK1geqbT/SHg4uRs3IJHbyftJibinJGTATnwSv
         v/kCdXO7BfSkGl3CO17TZTjeOhvsk0YF7Nm0doY4xaQFApUlCawsiKvqRsOU+wbkn28z
         7H2D6GrQx6FMT/1OGKMcWYm+17R3sP/QuqofDMVgsv16evxk966nDxoDrsaM+TCdnykG
         4iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867453; x=1772472253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvVS//J2RIviT1EM5PNeofKo+JkNGh+uX8BdQ0DJA+0=;
        b=qZhxjkuRP2HzucP3aMMKOI1wAQ2SxY/AKjZ1WObZ8caM0htB5yfBv8a/P+EBsiWDi8
         qzn4jEYErlGoPEn7VWppIU9HXVfwVHA5Ik7iLdpeRlcq/lhUZnLdzzh7Bl29Xe0CnvUw
         CqaWD5OY0/1Fog2c487OrBItJKPmIzwT3L/jNb2acT+wKSUVOkY0b/dnLI9M9FX/rAx8
         0ngdgTHUUDrcl11m3eAGO3Gz5lbZU/OXfwvgC60Oi/4qTcBk10h+VhD/U5VKKYjY3C6b
         gP6aU/h5CnuOSRFhUjVbrrBgOccPyMrDHicNrhbdlRIxahWhyDpqjzRgLIEIp3W4ANAs
         Cyyg==
X-Gm-Message-State: AOJu0YxVXdFCrv3VE/ZZzorR0Zw+xRWwR1KNJyxuSAWtaITrm3y8eCIc
	QXLvW675h+S5AlNPb9ESykMwhUxQdiMNXiAAMR9I+hWGJNdP7bGZ6KA7yxZpxR/9TXZ5H2wo9Qw
	JJvHi
X-Gm-Gg: AZuq6aIpTBNBl9Hd4GxHCvleRT1n5/i3HA3C7kpBToc/ytXV1MouJCoiuT1fMT1q2Hh
	t3PUMsdvB3VdKdf+cJYR2RW9jTFDXsPKjXyXglveSUMhFRHIhgA+Bm1fZ57/sRvTyaOGlSat+R5
	OhaPjPNW+e+p8rBgAYQg9sdiZGe8M611QupFGLLkNKPKIAb4GEwrg/KwvXM1x3xxsmPHC5CMoLm
	Uz6Lo2/2BOllYXWcioFgaUB3EYS+dXdezaXJ12ut+C2FULlJZMEBuqXH7uJYEkdHmlNMVhEDYvT
	qmB8RLXcDmCcgV8iU+bcHPtkIJNUtxwSnX+9mb1skrz7GDGZqahg1NSBctMyg1qktpky74UfpUJ
	57BPKbtPldgq5dnAu2tBjLRj5gn07I/0dipOuCQDVXHsT/rDlJI0lyVGEsEYod62gYDtI8+2dYc
	Usgto9lPqatxNxbJexQD/Y8nyA6zWr6SQ=
X-Received: by 2002:a05:6a20:2593:b0:38e:9ae0:3d5f with SMTP id adf61e73a8af0-39545ea4176mr8013265637.17.1771867452758;
        Mon, 23 Feb 2026 09:24:12 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm7802332a12.16.2026.02.23.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:24:12 -0800 (PST)
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
Subject: [PATCH 6.1.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
Date: Mon, 23 Feb 2026 22:54:03 +0530
Message-Id: <20260223172405.292040-1-jsingh@cloudlinux.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudlinux.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudlinux.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217803-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jsingh@cloudlinux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudlinux.com:mid,cloudlinux.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B875717ABFE
X-Rspamd-Action: no action

The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-6.1.y
was incorrectly applied as commit 3d81beae4753.

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


