Return-Path: <stable+bounces-242219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC0YEEvo82mE8gEAu9opvQ
	(envelope-from <stable+bounces-242219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 01:39:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA324A8E6F
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9773A301A902
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8D3D34AA;
	Thu, 30 Apr 2026 23:39:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89063C553A
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592347; cv=none; b=Jf3CJWXRHyw7ftRTzH3j++exOH1NPcrHKqucv+zc61zmMCwA/bmFBtEB3rfqJlCQcH5ec0yzzLu66c9+wv+mCEZOpdsFe4rcpYacUizJuUXq5R1vmCJXT1qwKYW7GYHgVAqJeatNoP73Uc/qyB6T6CvBr/ZGAIXkwCXFgciv8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592347; c=relaxed/simple;
	bh=RosUM6xPRIY1oTK9LeKQ/7oZG5o9uW6w4P5hZC7Uc/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZZe8pn6/Zwl7XbzTU8LEJPpyP+YXKOSsz+/YjXORxw+l6pt1r373YxLgjiZBAFIMEpHwIEs+9VEjqJ9mQxDM7kkNruLzbbVJtkq9EJlZ+i+5X+4VVXyuwun+0we9EEm5aiENUHXMZmxg2m6OntiZUaeMpGUpafgSRfZ/KiqlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-50fb8e9a4edso16376451cf.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777592345; x=1778197145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SA+eWHMkILjGV4lZwdF0bh9/zh8ox7+jWKzlWflnjB8=;
        b=IXBNwf/+QZzv/bixVFlgX0x+GRuRIQ9UROrMmCeCAmlKNQPT68I1Xw0fC6/QbTZdOs
         LZHoUk+AsxCcgS+4mEnOnM5WLIK0R22xc6s4BZRcrcUfbVOu+TQZxf4mluqpvk4i6Bly
         EMnOLy1VNeRNsXq2XNnDqe3/pb3mp96GojcwM1F1+8lo8I5Ht1aSg9+TsK4GESLk347a
         40wXWArAdYOEYbaUwpjMHKhhzoYLrd0sHMrSQx/w4Q4yTC0dRrwlPWyIhddDxSD38/vQ
         HkeHSUW9Apet91hXYKyJ0kSeJofAmTqKwfwMU+cFqd5fCAhECIpSj5/paIHe9v9Q4Qur
         96xw==
X-Forwarded-Encrypted: i=1; AFNElJ8lKJnG7qPK27npVUHjpbivQO7KTKG8JRwKuO/J6TBOdMjIfSI51Facab/KnEpszusTrMKI2hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvC3JKZyfKhzE+YAQFSG6wHtujEToCFS2sH41e07E8tNGMKHu
	JvBD2SdD64rXeVUG8P/Ym+FfXnHzBNy3OiY2XjuTOsyvc/Ty8CsxCtJt
X-Gm-Gg: AeBDietJlFr6kQhzjKxFlKoddCYmmwrkFcM5TcgBvntCcTopUsb5FEUW171TxCWQuO/
	z6YCC4ZwMRVeUuTiA2nhYDXCvDRVjyda1jeAS6oOPOt3EHwQbWSPOAzgjR/tkKxiSfKKg4T/SyX
	/LfumDkPrEazQkyWwPocNMaWt1bWqz62Fae+X9OjYxfnkeSvgiUdkCTBmrtXFw3SZRmwCXeHK4m
	Xf8JagK6lTiXwdpAFmfndRoekd8yGXKouFbZZ4EdFxTwAtOoyjuXx9FhD2QbZNjacji38BxxTdu
	pr+6zCW3DM8a3dHFQmqOoW7m076/LVmCvU6S90WRKHSG70/epdrK0UJbFTWWV4BPi9mjdG5xR3k
	szeX41rphpPsi1ephayiK59GjnIUnPcrKPD5cpGlmJX5SBPp4NFfutR+NVzJws9hcd8sAUphArz
	R7IwhRqsatTf0qEVi1z+ZCSWIPnPVIDj3gSEC4IC/QQNl2/Tl4cLu1xbBSB2koBo6+teVaew==
X-Received: by 2002:ac8:5a0e:0:b0:50d:8db0:7abb with SMTP id d75a77b69052e-5102adc9563mr74431601cf.42.1777592344891;
        Thu, 30 Apr 2026 16:39:04 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040934199sm221cf.13.2026.04.30.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:39:04 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Fri,  1 May 2026 01:38:37 +0200
Message-ID: <20260430233848.440994-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430233848.440994-1-i.maximets@ovn.org>
References: <20260430233848.440994-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DA324A8E6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242219-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

vports are used concurrently and protected by RCU, so netdev_put()
must happen after the RCU grace period.  So, either in an RCU call or
after the synchronize_net().  The rtnl_delete_link() must happen under
RTNL and so can't be executed in RCU context.  Calling synchronize_net()
while holding RTNL is not a good idea for performance and system
stability under load in general, so calling netdev_put() in RCU call
is the right solution here.

However,
when the device is deleted, rtnl_unlock() will call netdev_run_todo()
and block until all the references are gone.  In the current code this
means that we never reach the call_rcu() and the vport is never freed
and the reference is never released, causing a self-deadlock on device
removal.

Fix that by moving the rcu_call() before the rtnl_unlock(), so the
scheduled RCU callback will be executed when synchronize_net() is
called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
is already released.

Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
Cc: stable@vger.kernel.org
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc0..a1df551e915bc 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -196,9 +196,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev, 0, NULL);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
-- 
2.53.0


