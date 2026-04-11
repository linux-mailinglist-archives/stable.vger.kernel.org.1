Return-Path: <stable+bounces-235706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJuhBKMg2mnEyggAu9opvQ
	(envelope-from <stable+bounces-235706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:21:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C24F3DF4BE
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893BD3026758
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C533A6EB;
	Sat, 11 Apr 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdbsy5/J"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0731F9AB
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902836; cv=none; b=eDaeKEn6NGQdgglTE5sLgHIZ+wjQ9PzoREv+uY8WZ+3qsxpMf/D/qANnD1pOnYZufBpWsIPECPB4TtUnHzazGLFBMv8OKY1dP3CEN2y24SyjZuuCDGcfL6oTPL5Eh70UTxT6DgCUMiX2gZrQkloA3/fDJ0WWNGtSrwropEDebck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902836; c=relaxed/simple;
	bh=p+5B4jPBhBOvx5kgHpx2qT+m18TvdS/RwqUDXjp80v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejoFGP/NjRwwjSEJKbcCRZUYYKKgq4hOsaMvLSrV7Xjytdw4pcHNQuJ35biveRxKJ922xvvolE7hYnJOnFjQFW2Ur5RS5QvXhpwUGkzib3kMg7TpJeQd3cOsM7IgRoov4LMq05o3NIXddpOfmKCIv7T2g5j1zcyimn3XefqO4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdbsy5/J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so19479165e9.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775902834; x=1776507634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMU2VeR7Got/Cc+lj6WbOqkh3oK1G2LIaCzwnGt2eZs=;
        b=pdbsy5/JAnjm9WYJsemw+lF1yvhSN/EoLoTVYnhri8c+ficsmqC2OIMJvIsNNx1X3R
         ACwN0CNnNYBb2stw7ADAn8EnFoNwUhfyLCYmzw3CLVnQAv/mAmh3Tt3M9fRG3O/pADmJ
         6PYvjzPduz2xmlox+gxolCBc24GcsH5MVhG9PrwULV0sGwax5v3i7FrybnrYgX/ZnPKl
         azuKkotmcxR25yxNtA8hJS0fahiUxoz5snnaoYcvWQe2JnvfWrR1NvWQ+QDaPGvGo+6x
         d9ySJr3R6wrrUKelA5BmYac1epZr7i/c2IKDzH1kjgBGtmWWqfsrn/vBFYhtZuuB9ii5
         Lo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775902834; x=1776507634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMU2VeR7Got/Cc+lj6WbOqkh3oK1G2LIaCzwnGt2eZs=;
        b=XRjxja9yJibV8mPj01rfglUhPA24p6e9jlMRiYGt5LJdj+DgOCdpa42HmEZSBGjna2
         L2jqfwpc+WRvGPwXeG+fSeOhAIkaN8EdIa2loynadNd0vWW+L3C86XxPJU/Sq2bZWwwu
         32gGDlc5tAqN3KxwL1RU2CPRBFlLS9Ik0l/Wiq5QSlNms02Z78zHVqDrrODwUkPnWWOF
         CAO9auDS2Ta7IpYsFYf5hmTMSD5phrstqmAppZDDxTkYgVuZO1WVwG5pJrM0IvqQ3f+z
         FhZ+HOp5OqP4d6x9F90ADx0HNL539HPAXtqDJDklCrRHDL/duJZqsIbT1uHxKLnZ0DUw
         zC6w==
X-Gm-Message-State: AOJu0YyWBaXYbVrN/sMS81weMqlYQFbdakvPPFblOegDAFA1SFo3yeOp
	WrOEJLDvWYuk3cYnA1aatRQnvziOdKUEbX2S/jq2/+yTH34TY6amvtuP
X-Gm-Gg: AeBDieurJVELmCIwKcUTfXHv7MQVNqtonS4n/WTUkSMW1+0Fp+IJtKupbIjXgeSgI2B
	Zknb00wcYtv9vLVVpu0+KRbRyT04iqmbHb7LVoQQzcckyA53cm1Sex5s3t5ORON8dmJzV2ckoci
	rMBgL0iCgnZSW3pmVmrhR8a5r6QqAxV0+tW07FAOlWFEmFePPu8Wsab1ZBS+VfyBMkd1QHDsJBt
	IMGwyjWl1+d1c6aHSHqbOn6+VLo+J6osAndMjaZ1r97c2X2ClN2XIhhTGlUsIpn9/I6UZIkS9dD
	gICTt6DJMNU03/I9dQKLgx0zJzRJuIugDGnY5u8qf4LCtuN6fR23qHqx5KZQ9smVuZutbtRBFK8
	yL1EBtZjaViNrLm/j+jk5E85wllcYzzuiWvTyI/V/bimwSntXCYlkBIVun0Evphi7hyd9HRtksH
	X90guPYREuQyl/srNo4/+FsflHmDJugWG9NDzowkQ=
X-Received: by 2002:a05:600c:4e48:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488d685655dmr86640325e9.21.1775902833633;
        Sat, 11 Apr 2026 03:20:33 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ec15sm41856945e9.20.2026.04.11.03.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:20:33 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/2] gpib: cleanup and fix error code
Date: Sat, 11 Apr 2026 12:20:23 +0200
Message-ID: <20260411102025.2000-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235706-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C24F3DF4BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1: Removes some useless old code
Patch 2: Fixes the error return code on invalid ioctl commands

Dave Penkler (2):
  gpib: Remove useless code
  gpib: Fix inappropriate ioctl error return

 drivers/gpib/common/gpib_os.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

-- 
2.53.0


