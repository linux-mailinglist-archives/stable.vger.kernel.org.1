Return-Path: <stable+bounces-27583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71E87A713
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 12:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797C81F22208
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D723F8F7;
	Wed, 13 Mar 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hwLbK7fR"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000A3F8C7
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329218; cv=none; b=dLSVBKS+RhzF6Dl6CouKDhi4HIeQUcZ2Le0Gz4mKsAiOaZZs7Qrxcg3Xv6wLoxw8I2V2+6cQ+kFsmYHdh/fWVGvwE9mzkJhK4iBX24TW03WMNntU3e9u9Dbn9Goxxxns/+O9xcKoig2xQM4TMb0QiAYQI1rL1c32+zJzQcecgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329218; c=relaxed/simple;
	bh=NQt8NTW+q0brSzIrik+jUnUM5EwnMAPXW7RAkBx+yjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=DZ8lwwlkI0U6O6r53gvtriwdI06PAhEU4eyB2/jIj6oBxsltTZ90tE4T5UYSDM+xWSKhRcRvzEfuRYuQ7HPv2xGcRg3L1ZozdMco+NibaWpbRUlkDaPDDJoVDz/TISRHB7MfWuNOWKwm1mGrtlPbfd/RYIbkQxr4MgCQCKxthXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hwLbK7fR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240313112652epoutp0235a0b47b17098f1d927bde88e0fd434b~8T1tzhgm11521515215epoutp02g
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:26:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240313112652epoutp0235a0b47b17098f1d927bde88e0fd434b~8T1tzhgm11521515215epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710329212;
	bh=o6ngaGJT6sMQ0sj5kIMIyQJUOCiXhM3e9x+mfasClqo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hwLbK7fRYv4hhJWnFNDt42HeltZoRu8C1hoEDuxZZHqcAdhvnZta8qqxpipWSHgDP
	 x4IIxgPpRvTvUIVYgeN7AIQvCOI7v9ZmgV26he2LDWRQ9S5Lsm8wfDEFJm7WMTHoFg
	 6qRbnvTrGVlPq+9AZt07D9SoGrMj+krMbaZXxzPA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240313112652epcas1p1f90dda2ac39c0010f7e36e8b2890fdb2~8T1tM7zIe0889908899epcas1p1I;
	Wed, 13 Mar 2024 11:26:52 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.248]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TvpBM4knLz4x9Pp; Wed, 13 Mar
	2024 11:26:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.64.19104.B7D81F56; Wed, 13 Mar 2024 20:26:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28~8T1r92KDh0101901019epcas1p3P;
	Wed, 13 Mar 2024 11:26:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240313112650epsmtrp13f0dc0d8f8829d2f9182c688f6d17ccc~8T1r9FWvX2300523005epsmtrp13;
	Wed, 13 Mar 2024 11:26:50 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-c5-65f18d7b0df1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5E.30.08755.A7D81F56; Wed, 13 Mar 2024 20:26:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.34]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240313112650epsmtip130c69cadd9fa5cb6e282857325ded076~8T1rvUMQr0971409714epsmtip1X;
	Wed, 13 Mar 2024 11:26:50 +0000 (GMT)
From: Sunmin Jeong <s_min.jeong@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Sunmin Jeong <s_min.jeong@samsung.com>, stable@vger.kernel.org, Sungjong Seo
	<sj1557.seo@samsung.com>, Yeongjin Gil <youngjin.gil@samsung.com>
Subject: [PATCH 1/2] f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
Date: Wed, 13 Mar 2024 20:26:19 +0900
Message-Id: <20240313112620.1061463-1-s_min.jeong@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmgW5178dUg8bfihanp55lspjavpfR
	4sn6WcwWlxa5W1zeNYfNYkHrbxaLLf+OsFos2PiI0WLG/qfsDpweCzaVemxa1cnmsXvBZyaP
	vi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
	CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5da
	YmVoYGBkClSYkJ0x6+lKpoLnPBWXHv1jbGBcx9nFyMkhIWAi8X3BauYuRi4OIYE9jBInp3Sz
	gCSEBD4xSmzt54NIfGOUWPJ6DxNMR8eeeawQib2MEgu/HoJygDpW3vvJCFLFJqAj8XDqbbBR
	IgJ2ErduLmIFsZkF7jBKrHhQB2ILC3hIdLU+B6rh4GARUJW4MlMRJMwLVH685TgzxDJ5iZmX
	vrNDxAUlTs58wgIxRl6ieetssLMlBG6xS0w/e4YRosFFYkf3WqhmYYlXx7ewQ9hSEi/726Ds
	Yomj8zewQzQ3MErc+HoTKmEv0dzazAZyELOApsT6XfoQy/gk3n3tYQUJSwjwSnS0CUFUq0p0
	P1oCtUpaYtmxg1BTPCR2tl2DhmKsxLe1z1gmMMrNQvLCLCQvzEJYtoCReRWjVGpBcW56arJh
	gaFuXmo5PDKT83M3MYJTopbPDsbv6//qHWJk4mA8xCjBwawkwlun+DFViDclsbIqtSg/vqg0
	J7X4EKMpMFwnMkuJJucDk3JeSbyhiaWBiZmRiYWxpbGZkjjvmStlqUIC6YklqdmpqQWpRTB9
	TBycUg1MHUunzYs0fHdcPmr1Z97asskXs6PTK1wfFPhOyYnROHUxfp8En/WWN/WbZ2Wlpcb+
	u3aiI3Ha6ccnO470SV/pZgtQm/VRc+/FV4xBn3RUvvg0zCxb9ubig7pHNk6Caj7+1QLxm6/v
	+pfw6s4K+XIRoR9aL5/9OThvV+/Hkzan8uZ7pt/farqYve7K3p/bb0Xmlk/5sv5oQsm1cydr
	0k4lLvRd7WVQ5Mi15eeaNdH5/Fodfhf4my6VJX9qyK7beObjU79HS5k+yZewyjoneD65PNlY
	wphfOi+PcT//cpuSOzynjq3Ys8Pu94Vn6raH+Fb18pWsrFzDwy648tYbPdlDO7PTl1lK+Suc
	5/ih9SzGWomlOCPRUIu5qDgRABEsaoISBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnG5V78dUg76zKhanp55lspjavpfR
	4sn6WcwWlxa5W1zeNYfNYkHrbxaLLf+OsFos2PiI0WLG/qfsDpweCzaVemxa1cnmsXvBZyaP
	vi2rGD0+b5ILYI3isklJzcksSy3St0vgypj1dCVTwXOeikuP/jE2MK7j7GLk5JAQMJHo2DOP
	tYuRi0NIYDejxJpdq5m6GDmAEtISx/4UQZjCEocPF0OUfGCUOLLwBgtIL5uAjsTDqbfBbBEB
	J4n/N9rZQYqYBR4xShxqWMgIkhAW8JDoan3OAjKIRUBV4spMRZAwr4CdxPGW48wQN8hLzLz0
	nR0iLihxcuYTsJnMQPHmrbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWle
	ul5yfu4mRnDIamnuYNy+6oPeIUYmDsZDjBIczEoivHWKH1OFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ84q/6E0REkhPLEnNTk0tSC2CyTJxcEo1MK3/9u6tucwaiaOZ06dxt8Q+uJldfjL3W4xm
	01yzAzMUmpz3fSjo31e6IePvaVuWzCSWKj7O31eLL1Q18/511jx7bdeJx76fzsf97b+y99x+
	zc43SjfjvxervPsnsepOU8WcqfHNgcIH5GZz3JUwmTXxeFLE6j1v3iTHfOHW25ula780PCmS
	P7RW7girR6qERJ7Xqw9X/0WWpHK457/vn+m0587ZyO1CD8/v2Sq57reW64M31nJ8PJNzSptP
	TwvdbKH/3re5Siz0fCP327LDcUdEO7TPye6Zxygru/unX+MDoZXeK3fs3vdw0+wZCb0uF1zy
	A1TqzNkfqkrqaTkY/sxlWligJKxb1TVpX82bZiWW4oxEQy3mouJEAL9U4hHIAgAA
X-CMS-MailID: 20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28
References: <CGME20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28@epcas1p3.samsung.com>

In f2fs_update_inode, i_size of the atomic file isn't updated until
FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
after the writeback of the inode, i_size of the raw inode will not be
updated. It can cause the atomicity corruption due to a mismatch between
old file size and new data.

To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED

Atomic write thread                   Writeback thread
                                        __writeback_single_inode
                                          write_inode
                                            f2fs_update_inode
                                              - skip i_size update
  f2fs_ioc_commit_atomic_write
    f2fs_commit_atomic_write
      set_inode_flag(inode, FI_ATOMIC_COMMITTED)
    f2fs_do_sync_file
      f2fs_fsync_node_pages
        - skip f2fs_update_inode since the inode is clean

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org #v5.19+
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 543898482f8b..a000cb024dbe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3039,6 +3039,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
+	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
-- 
2.25.1


