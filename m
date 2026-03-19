Return-Path: <stable+bounces-227306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNHBCbEBvGmurAIAu9opvQ
	(envelope-from <stable+bounces-227306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:01:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886372CC557
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F19231EDD60
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29A3B893A;
	Thu, 19 Mar 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKmjUOl6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135327A462
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928768; cv=none; b=PCgFqd1YOoJaj8DZUjfhkbl2ugDm11ZoZRP3cguzfBkIdOcS626W/Nca7MtRt3TKWG8ebM/3cAnnN0hQMhgk72MsPRd7BlOcKIpCxJN8daUuGGbzXGScaHg24AaY35u1g2YrVX6DG94lsiZe9Sz9EBOq8fhsotWxFiYClsm4sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928768; c=relaxed/simple;
	bh=rQv2vpKuDgBeqdlFp5TZxrVVv0oRHZC/jYJEf+oSJDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A917lgFHmkGHJrKhyoE0Hqe3fockmZ3thlPkimhytIjMK/xdG6mngLj4G45tMB9DOOB4bzJSRyUNddLNU7OZZbc4GMAImCut8lNUlG0/7T/42wSm2O5wZNE4rfhUzAJVKUtuGTvNqJRobVn7iqHrIJTn62+5zzu412P7BvBC/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKmjUOl6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824c9da9928so756930b3a.3
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773928766; x=1774533566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM5u2uHSz/VZ9Qz362czB/Bn/2senFQYOZTR+Pv+J5M=;
        b=HKmjUOl6448b4oWGENYCkOVpT+xqBBuzwUlsdYvVkvSqCb70AievInRTG4GnNDHIbz
         VCxZRdOkrdHUgbbzr9o443vsvQTSQ2RLRFQR+Xr4sFg+aDDi6l6PKgD3LWKItoR05xTd
         uCatJu/2CyVJbw5KWbpB25ZJcZl7nHMKeYyX7u87kgrYT3czfAzYYL50WIxzXRTcHXI6
         oAltAc+i5/ibkMOzAclcDRz+aX8OlNdGPlYZ+a8DJdrFfoEfVXUgNldOizfYG4J6RJwn
         2H+4dQcs+pjYDLlKRSOQoA1vamzjYbvIHlpLcTDUueR7ABBiFK7+DjhFf34rhJx1BzrS
         Fonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928766; x=1774533566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM5u2uHSz/VZ9Qz362czB/Bn/2senFQYOZTR+Pv+J5M=;
        b=nMYCluC0mQyKZE4eEbxJw+uO2M6jXCdzgmt7JZFdM8wQwVyCRX4s4JkbDJHlTz5Xll
         iO2DxmyS/5VsyH33we59rtBUwmLDekA1GBXZYVtomezvNN6D4nNuYkGzkJ9DwU+8WpFc
         cO7pcfWdk1QXwAwqK1cJsr5JMOEK7fsSpUk3Er1w1ylCDZYNrxSZ5GFjpfx2xZUL9CjD
         KHXJ0eBr/q7AF+9CjmOPO9ExEYn+dcHH7997NOZ7zz+usCQth++KEx1Nxb6ktnawZpp9
         L3F6NlIDQp7Mq709rE7AbdzF7zjqEitCJgM0Gyq1ts+OntalxV14dhvz4lOIOpeRw7th
         Ow1g==
X-Forwarded-Encrypted: i=1; AJvYcCUI/f4vjEEObIH+srATqsD2YepXz5O4b1DTOoOfI7mUsKSrSKQetVRJjd6dV07zNLhsa8fbjuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOA5wD5UXOXlmpJlN69tH9VYXuV3SCJSXN//vF9JGeeiYmuXho
	CtotAZ1fHt8A7iVn8lAS3mcOd1WLTt5nuY6OaMvD3F1THQ9LJnl4pAvD
X-Gm-Gg: ATEYQzw6fsNFKgbaZptag97m4FA3M9GjYUKeTz6xSVxqGH4r9hAAxsK9hMfo8A7/ILo
	uFLP3Xxm/YFmTc++XQd0dkAFFLQ+Ipq6rFYXs626o+wdQhy2LGwuJHLMlwjjiqpjQQ4e9czVPBR
	zO5lRqLMZa2PMdoCAi4y/h4icnhXY0bvTEJ+LaTZW7n17qLfKx8c4jYUhk6PJU1NGGV0pCjtQCG
	qllfGEa1m7K3idPc2df3Ece1Sdjunm7WMkBJaJhuJwgLmYAItkUmK2bUnD/tmygrM0i7aqHsDWO
	zjEw9aDFo8WYllWt6WGbt9l4TLVrMAT5A6VJWBCuCdhdMNYmGGfP5r6YHf3E9y1lV3NGQ9bDsFg
	t0dDYYnlU49O/awy5uC4q2Z8GlXg1/nJZseB4ATWc6Jt+ZpQOuywGdt78IBxfC4LsxqU32O/eXZ
	jxEfjYCSCe6FTm55On0qxw
X-Received: by 2002:a05:6a00:3319:b0:82a:6255:247b with SMTP id d2e1a72fcca58-82a6ae78489mr6376248b3a.62.1773928765908;
        Thu, 19 Mar 2026 06:59:25 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b56df09sm6237700b3a.21.2026.03.19.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:59:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2] ice: fix double free in ice_sf_eth_activate() error path
Date: Thu, 19 Mar 2026 21:58:59 +0800
Message-ID: <20260319135859.690041-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227306-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.753];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 886372CC557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).

The device release callback ice_sf_dev_release() frees sf_dev, but
the current error path falls through to sf_dev_free and calls
kfree(sf_dev) again, causing a double free.

Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
avoid falling through to sf_dev_free after auxiliary_device_uninit().

Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - replace goto xa_erase with return err after auxiliary_device_uninit()
  - avoid xa_erase() in the auxiliary_device_uninit() path since it is already
    done in ice_sf_dev_release()

 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..f7266d036815 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -305,6 +305,8 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 
 aux_dev_uninit:
 	auxiliary_device_uninit(&sf_dev->adev);
+	return err;
+
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
-- 
2.43.0


