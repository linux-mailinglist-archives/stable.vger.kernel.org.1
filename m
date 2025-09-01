Return-Path: <stable+bounces-176873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C9B3E729
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F6F1881CAE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E53341641;
	Mon,  1 Sep 2025 14:29:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE12F49EE;
	Mon,  1 Sep 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736975; cv=none; b=CRgnOiEwBL0Mdis7mU7QOx5h1+fP3HAtLkEZuKjEVrlQeq8A4dKRao9Qo/RZDz5+qfGnPpIu3SqbgtbvWPYVh1hSrTNHLo/SphN+YT7yZsbSz2OhZewbOhpEaSffNptA6N+58o24TbALjsEs0cNomOma0AJRqePBfuY/BLr2GZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736975; c=relaxed/simple;
	bh=rIc9PaP5Dn/UnXTwF/5gEzVX6ZfvAdPwwxjS/weWLp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VWOSxcS1VtPElXn11VAhj5LEsiFpZH5CSkYVPvSzgVS8VB81mr0RVVPVYNDr9exTBCZ7kg92VFPbdvN/VJ7U/Ku1GaFt4n5ZopW5yNl0n3T50XLUQMTwWlgmXYmO/gbwSJuUq6sjA+EWJRwpvT72gbc07JJet02NIbWouj+fCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso5645641a12.0;
        Mon, 01 Sep 2025 07:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736971; x=1757341771;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NplgeWcNTOnynvORO+lXqHJFAtHGQ9bpXO8+3KZyIv8=;
        b=PBMpjxC9zUgiC11DCKHDVqyACQGANG0BS6ltiBwPMml1R0aDSCONVRdV3rShdbNAk6
         rTRk+Xkk0evHM+zvOMatwPrHbdfDgMe+74L+MR4oK8bvQDum+PbvDpc6BKNfYvyEf2HE
         b3fjHFoJLvRv/gude2IUkAOChYS9aha3vJxlNGx4TrhvsrvivVhUSsv3nGu3KbdiySmI
         NsEImrehrU4Q3h8BqN3Jv71Z7/Tn5fOAJLt+h8Uf5ODu+9d0TKZrgHcg64UNpy7+2TGS
         /sKSpyygZSHJx/FCOwIEjL1BWMLSt9C0myDE5rkNmDEj018s/2kZBHWC9e/IwcutoPxU
         oJSA==
X-Forwarded-Encrypted: i=1; AJvYcCVzrFe8sNYlCkvg1pSzXI+VZoalutriNwCTR8ES8wC0GEqOUCDIcfhMDcxGEJLwnOL95Av9k6XA@vger.kernel.org, AJvYcCWDqNd8nPE9EYNfNhI73qcqPvVtFx6Vy2HRd5KeTDB3vOkltimCI3gIKFELnSyKAsmoZsd6qIMZIqr3lYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC68O7MZxR/bKwnDC6FX6QpIve90WOavl0XNClNUX9NuWKifSA
	m9LFX5keSdpuarzeAZT4UguuErVVuEzJyzXnvxeN1MIYTzK42J1u72P3OHmEmg==
X-Gm-Gg: ASbGncveC9GsZBG+leGty5HZbZp+xh6++WSlJXgCNQDRqYAhYi+oiCtNi0EGwFM0O9e
	/ZubNyPjMU30mhi8EpToQ+kGwiknZ/cfQQDAV9t8jXe6LU+a9r2UeC0zPyXfcVLgGxWun941NWg
	TnVS7HnBNHHU3lSkBrujzTlu8kwXWE1FyCsOdvht47YFHJBPvs/qhyjLypULbLYzRAe1XplB5aS
	T+TTaLKlD7rCmobcJYCaKfuiyC4kZlJzpWGYbA8XfqKuXeJ12oI12CX7ycEF4Yy/cI7EZwdZB6d
	47BOAf7OpS4RiYxUi7nW8pLBp9whFnPM4S9F1OvEC3c+EjeZTAJrMe0wK5GYDYsZHpNbz+D+5Z8
	npcGXuKGO9h7fdt+MgoeJI+/E
X-Google-Smtp-Source: AGHT+IGBIGQeIkdga89sLFjwwgHh8OYnMDrUbIJGCO8aVa3tpGY6JBZWq8dWt/C4qF/ldn1mbHERwg==
X-Received: by 2002:a05:6402:210c:b0:61e:a5c8:e830 with SMTP id 4fb4d7f45d1cf-61ea5c8e868mr1893659a12.1.1756736971012;
        Mon, 01 Sep 2025 07:29:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a8fsm7275979a12.3.2025.09.01.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:29:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 01 Sep 2025 07:29:13 -0700
Subject: [PATCH net] netpoll: fix incorrect refcount handling causing
 incorrect cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org>
X-B4-Tracking: v=1; b=H4sIALmttWgC/x3MUQrCMBAFwKss77uBbVBKcxURqclTF9O0JEWE0
 rsLzgFmR2M1NgTZUfmxZktBkL4TxNdUnnSWEARe/VlH7V3hti4532bOmdPbjZo0ne5xGHxEJ1g
 rH/b9jxcUbrgexw+Et+TnZgAAAA==
X-Change-ID: 20250901-netpoll_memleak-90d0d4bc772c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, jv@jvosburgh.net, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035; i=leitao@debian.org;
 h=from:subject:message-id; bh=rIc9PaP5Dn/UnXTwF/5gEzVX6ZfvAdPwwxjS/weWLp8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBota3J1vyCtlP6LNUk+o4zFSY8qigmfKO1Spm1y
 ZSjNgJviTmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLWtyQAKCRA1o5Of/Hh3
 bUnuEACgCkzBAIx2/Shph1NfT03nw5u5yMoAbMncpCQr+7K3gZgqPGwuvZ66Y7sqJ1etfm+J6P7
 Cm5uE9Hk56rVF8nxbzUmwAfMf7dOy1BCP8r735LTGAA72a/A4OaGeh2t7NhACOLuMn4mIGLcHez
 wQW8PZkipq5Q0C1kG0sj020pYP8fj05Dbu+em0RdtwkS8ESyFa8KxZQ7NbQ3seXQ1RarNETNRRh
 MCcDzMfnRCt8GkJFvOgKZJxKo37oi76tO0c57vLdddAqRmHDgdoU9FtLf0zUWPPJr5GcmS0t0FS
 hfvYDo/N3M6RsJLyw2tNKhwo1l20sFKqM6vdXw1L7pfSiMWUXhgZQjnKuUDkfr+nvD/lIb1gyoh
 350dkh+1tpqF7mIGgfDgJYlh+k5ycY1oFBz+iCWxva7dUt/aLIXkO9zRwGzIPAj9OcB5SwE/5va
 tdfj4+jfE0mdSs7SirfYt6x7euS2RAqSpgfQxzEdH8E6UY2QqfBqy5QrNU5AUkijl7+hP/tXUVR
 ZayjxIuF8yYxrkiGjAZwxy3OC9jyM1i0F0GryXGLhsDTreZHP8VQ7z0Q8RRCXjC6LJ3OKPav/cO
 NvwalU6F2i//tsE41EBYZmt30ivZ+aibPwJZuUh/i67t6Fan/jtdUW/W9gD+bNsZrt3AAnKGpfW
 B/vWc5Yc91SLMPg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: stable@vger.kernel.org
Cc: jv@jvosburgh.net
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
I have a selftest that shows the memory leak when kmemleak is enabled
and I will be submitting to net-next.

Also, giving I am reverting commit efa95b01da18 ("netpoll: fix use
after free"), which was supposed to fix a problem on bonding, I am
copying Jay.
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..19676cd379640 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -815,6 +815,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -824,8 +828,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

---
base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
change-id: 20250901-netpoll_memleak-90d0d4bc772c

Best regards,
--  
Breno Leitao <leitao@debian.org>


