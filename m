Return-Path: <stable+bounces-211504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJi8AUPRdmmyXAEAu9opvQ
	(envelope-from <stable+bounces-211504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:28:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726F8381C
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16FCA300E707
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 02:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE928E59E;
	Mon, 26 Jan 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSPmH/sM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400F28725A
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394469; cv=none; b=oItjBXdIjU3okwQb2LURSzSeG3nRIFZJcxVtJaybQ9tvZ/hhWwwc7JtOXJeImtEkiaCpmB538gblH4g5Jqkdbkp3uHzKXX33C6AJNrYf+HnEI4ZxkAhxaKWSu1Dt5oXJn5+fmM4QllQxT5G6+MCqJ67N0tLTVM9YWWPXnWc9IzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394469; c=relaxed/simple;
	bh=elLdawZdiNF3T78K+DA6DMPmbUn63JQVKocXOMorMwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSxX+uhRZ82i80mew0xweaD7dsegc41sxjVwW3oWEtD9yodVLcYxZ4578HwhI+ljPkiZBVZmZ0E+ERkJq0WAXxcS58iYVICBIElBMeau1dAXUi3cOfKYZUgHYXBG7lnoEaMoQrjvlu2qO3hEPjuzxlybwF0W3gbWd/Y/hadOqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSPmH/sM; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233702afd3so5469076c88.0
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 18:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394468; x=1769999268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuyRS9NwFd3elvIRvYUasvxQvQ9+X8/Y2dmyuDNlfJI=;
        b=KSPmH/sMAr/HOFG43/OysDUyiVMiYdgbkVnXZKOPH8d7a0c13eW8OeQ70FZe7+lnPE
         X2xVsgTqrz0QWmhQj6gMRK8ipTh2v8zbBEhvDtL3m6b8uQKmR0qEAApsq4CY9UMwEyW6
         McNXdbzayMYeR0mVKUS7vQZvv8DENwON3kwbgQjKHrANXFDwLSKg26Ydl/vWvsJA6gbG
         wYwjbK3ikxsUbDtop2i/EWSpwLCjbk70Wy+lrxEqaTC6wbzTAwZs43fQWgN+xyIDqiuh
         YXBNhSm7RjQcrsxwArChGWdarK2rTRVb+0aLh49p5/gmqYmnM8KCZZ7ZzHhp/6VuS9Vz
         L1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394468; x=1769999268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuyRS9NwFd3elvIRvYUasvxQvQ9+X8/Y2dmyuDNlfJI=;
        b=mbmACDFnAMzooqnRNj27WNul78CbdmDFfIaunsHr+GvX0qrWf5cfi2zAFz7QkoimuX
         8VTVv5msGsKlLSO7eF2WqXElWgAVy4RXLwrjg03F9dKnMjvW18J0OCR84sqfOhlLq2X0
         uzPVrzyjIHgOx4Xp9Qwf460qMjqP5W/GjjwjVxLqlpx+pSCjhFBPC3kxmYGc1XzDfD8v
         QPz+WbVX6gxMBSR18Y/esdREH75rL+pedbrgdZI6gwykDC49As1W8U5Nmz7vDBRyUjzb
         CqcfgazCyjrIFJTJ/+VznWBbljLmVC0gHpPeWwkAX7tmd216FkbGnoS/BkSn053HhZ9t
         D0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUFP0riHegFhgJA4oPbfOYor+0Ws2XKKGERPwq7iiJ+uo6SEmsLyn+aRy8ltJFNTG4H+EtSyd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGAG2662P/WCB4+nkeNgwWZhv68hD4rNJS3fG0po7hxiq/SLt
	nT781PJbB+4ea3ZhS6N5qjIVdyheXRvqY/KOQRyPQYyRth6eMS+yAHvGH++eDmJd
X-Gm-Gg: AZuq6aLvCgyg/vxi20L85sH/BOUo80mE+n/KIMjp8SO1TJaWT9XRn0kA6BSvXBm5nEP
	jNJ4MD81W7fYkU/iXv4RvnmuTogR2Q8Em+yg6qjynodsp2oZ806jzMYia3+N+IgDib20DqVzH2w
	yXMxo9tkCRdHv/6Y3tO3tkuptult/2JIinrLfW/XuFME5KLhgSv23D7zXOCu+ry2cdXehx1uN1Y
	7FYcYn6BksAmKxqzpjyP0l5qBbzYq5kcA45jiggC8AiXFoCYDTN0E2FpkyaUD0eHARiwO+551Ng
	cye0WqPlVv2NnYTWRbCkiKRU2AYw29/k6AQ0Mkb1mYBOUSHFDy7zrriA3i3V/y0a8U1kwI4u6O1
	NwP0bwuHmTRhGsNpFRHNsldNqQIRJivWzAuA/EEgA4X8QYjl2dzTaQcDgsvjNsVcbjhm5dxam7G
	h6aXmdBbUqpGhRiSVvhBjmT9Mp0IBKU5dhxTqNvj2Wn9miC0HPNRzQ
X-Received: by 2002:a05:7022:497:b0:11d:f44c:ad97 with SMTP id a92af1059eb24-1248ec6916cmr1706255c88.24.1769394467722;
        Sun, 25 Jan 2026 18:27:47 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm15266037c88.1.2026.01.25.18.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:27:47 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
Date: Sun, 25 Jan 2026 18:27:14 -0800
Message-ID: <20260126022715.404984-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126022715.404984-1-CFSworks@gmail.com>
References: <20260126022715.404984-1-CFSworks@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ibm.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211504-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6726F8381C
X-Rspamd-Action: no action

If `locked_pages` is zero, the page array must not be allocated:
ceph_process_folio_batch() uses `locked_pages` to decide when to
allocate `pages`, and redundant allocations trigger
ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
writeback stall) or even a kernel panic. Consequently, the main loop in
ceph_writepages_start() assumes that the lifetime of `pages` is confined
to a single iteration.

The ceph_submit_write() function claims ownership of the page array on
success (it is later freed when the write concludes). But failures only
redirty/unlock the pages and fail to free the array, making the failure
case in ceph_submit_write() fatal.

Free the page array (and reset locked_pages) in ceph_submit_write()'s
error-handling 'if' block so that the caller's invariant (that the array
does not remain in ceph_wbc) is maintained unconditionally, making
failures in ceph_submit_write() recoverable as originally intended.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..c3e0b5b429ea 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapping,
 			unlock_page(page);
 		}
 
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else
+			kfree(ceph_wbc->pages);
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
+
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
-- 
2.52.0


