Return-Path: <stable+bounces-198177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6FDC9E534
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 09:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92F92348ADA
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA02BF015;
	Wed,  3 Dec 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKRODfUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB22BEFE1
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752245; cv=none; b=ZcrtTj/cmvEifpW/2+C3FPAefM7xwIP6vrb1xrtfXqbQaY02scJNjQ+7ulfXI3g+6nahHVoK7zBGsVP/mF0HVIISFIn0rA9c2E3NMcMWjIxDFWev2qETStuu1S8RYQ6BQ3sQm8BOQPU8gNTgGsJjrfi8xcNtRD0BzVfoZMYkNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752245; c=relaxed/simple;
	bh=eHRpdG5z2aga+e1mfof6RZCnYmRMfjkDnwPbzUWOQuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JYIa4JssVTN2KvXZ3ZdfzJGFOBxeZCEoDSjEsQDqKsIKzXBXchBNQxa24khCJiIHN1DkZbCD8QV9KqHaOtUooYvO5ayMZkACkuNjaNiPv8ke4PczCPxthLqstjB0UH2fydcavB4MXJqMYpSu+ddCRYG7TDwrxGFttSUyiLEWbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKRODfUr; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-935356590ddso1739729241.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764752242; x=1765357042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVI08zhNBg01YgaJjiGFtDd7DGJdSheO60VhOBD7FrI=;
        b=YKRODfUrliAZrb1tsiz62HrMfcgT+G8D9syPXCD8PJYn11nhNOCD2NnrnXV2KunhQQ
         6gOBXxUEmx5nCykKwps30mQTWbHN97cz0Yek6Hfsln0tGfREa/VHANFX8Q9k8RGpr2lE
         A0aCysIiyvSaPhnEUCbayW2yx1+iZGiD2TXAYvqQkdTp7LaxcClkfhI3/cjrk34w3/CC
         e0g+7BdY/yFAYrZrdez1itPVp5cueREHeHY8rWestfSeGlc4bRFgZYmz0YJMU9dPfel9
         NLdGs2O0x7JHnwfx6q0X4Tth4pVrGuxQkMEvzn0Tos4TS02KtM6l0WgZmj5UaLL7olEs
         X+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752242; x=1765357042;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVI08zhNBg01YgaJjiGFtDd7DGJdSheO60VhOBD7FrI=;
        b=xRwN18eGifLNSvChsDyFGexgyzy1JqLu7NCPAKOjUoF0sgCEr3wHnUQ00lbpSx3qYK
         3rFv0xWzT7VFjxBAkqxXq5o3f8GMHIEv+z+no1jRuwub1aVBVVopC/xZ4G/FFaQCflPx
         fTCUwSIgi7YsIRZsHileYwheyJ2fDFbs7FCIVZl5oT9PjaLvyWEB5Fq7SUZ+yBSg1yFq
         dm2/Y/Wn3JOthtMH9NhCY9P6sJsS9TXjxAef3onqMvyMozR4F7EMIhnu+VCm7p9UlZLA
         9qBuhP44LRGP7bV3lxDJpg5Jif8QDdzDN8tNcpW281Z70yNXD0ALjakAy/Tf+aNqLRm9
         +/kA==
X-Forwarded-Encrypted: i=1; AJvYcCVt7KLiQk4jYTDYVcrOmK1Ga/dx+kcBCwfiEKWhN6Mg1nR1BROawxEh4Wr9DkE2vDyJTtF9hKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSn6SGaqDs3qq+1eo0pL4P6V5NiWjkbw3LTPYecFQ+6b+XY7u
	vCRdvm6mrBprIEv+YlhSHDu28L3IXPzX0WKkL+AbuXI9rpG7ChjOyFIXCR+bCY6iZyd5l2q3E7N
	/fH5cm0XFRtV3lJwaQMPVrx/LipOnJAY=
X-Gm-Gg: ASbGncteshPo4zxdISTLMcsIK4wjLS/Jix8jQYRYDwsX2R8ZO8TU7LARrDcxCNY5W+s
	ydX/coaxWBm/4F24qj1nqj/QKuem72x8QfDoChFdDVrC+6DJrr5L/MI8K4fX28BXj3+ccy4RKte
	YxMe/i/yqxtxCLsD4QjzhfDOYRXWGRWwcw5ukL9cs8QDhvhPrxHP+dQPoayIwwph91dmRSZpmUe
	tOzYXgkG8/uKqNfecaXA4FHHdqPWBk2nl7iy4+l8CWsYQ3kQGZUyo/tLNxtwGGs81JQNQtV
X-Google-Smtp-Source: AGHT+IFqR1RlOPr0NrhhNnNT/JROqcmAinCel3zu7vS1LcXenQhfgtjPJarMmUKBgftae+FRX85qaxsmm2cZ79jyma4=
X-Received: by 2002:a05:6102:3ece:b0:5de:694:15e0 with SMTP id
 ada2fe7eead31-5e48e53389dmr343758137.45.1764752242159; Wed, 03 Dec 2025
 00:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Minseong Kim <ii4gsp@gmail.com>
Date: Wed, 3 Dec 2025 17:57:11 +0900
X-Gm-Features: AWmQ_blcJNIZtmzzxkMd8_nlhTZCYk284PzT8yaXGT5sjpokvcLllbLVfYps7ys
Message-ID: <CAKrymDR1X3XTX_1ZW3XXXnuYH+kzsnv7Av5uivzR1sto+5BFQg@mail.gmail.com>
Subject: [PATCH net] atm: mpoa: Fix UAF on qos_head list in procfs
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

The global QoS list 'qos_head' in net/atm/mpc.c is accessed from the
/proc/net/atm/mpc procfs interface without proper synchronization. The
read-side seq_file show path (mpc_show() -> atm_mpoa_disp_qos()) walks
qos_head without any lock, while the write-side path
(proc_mpc_write() -> parse_qos() -> atm_mpoa_delete_qos()) can unlink and
kfree() entries immediately. Concurrent read/write therefore leads to a
use-after-free.

This risk is already called out in-tree:
  /* this is buggered - we need locking for qos_head */

Fix this by adding a mutex to protect all qos_head list operations.
A mutex is used (instead of a spinlock) because atm_mpoa_disp_qos()
invokes seq_printf(), which may sleep.

The fix:
  - Adds qos_mutex protecting qos_head
  - Introduces __atm_mpoa_search_qos() requiring the mutex
  - Serializes add/search/delete/show/cleanup on qos_head
  - Re-checks qos_head under lock in add path to avoid duplicates under
    concurrent additions
  - Uses a single-exit pattern in delete for clarity

Note: atm_mpoa_search_qos() still returns an unprotected pointer; callers
must ensure the entry is not freed while using it, or hold qos_mutex.

Reported-by: Minseong Kim <ii4gsp@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 net/atm/mpc.c | 60 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 324e3ab96bb393..12da0269275c54 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -123,6 +123,7 @@ static struct llc_snap_hdr llc_snap_mpoa_data_tagged = {

 struct mpoa_client *mpcs = NULL; /* FIXME */
 static struct atm_mpoa_qos *qos_head = NULL;
+static DEFINE_MUTEX(qos_mutex); /* Protect qos_head list */
 static DEFINE_TIMER(mpc_timer, mpc_cache_check);

@@ -175,23 +176,45 @@ static struct mpoa_client
*find_mpc_by_lec(struct net_device *dev)
 /*
  * Functions for managing QoS list
  */

+/*
+ * Search for a QoS entry. Caller must hold qos_mutex.
+ * Returns pointer to entry if found, NULL otherwise.
+ */
+static struct atm_mpoa_qos *__atm_mpoa_search_qos(__be32 dst_ip)
+{
+ struct atm_mpoa_qos *qos = qos_head;
+
+ while (qos) {
+ if (qos->ipaddr == dst_ip)
+ return qos;
+ qos = qos->next;
+ }
+ return NULL;
+}
+
+/*
+ * Search for a QoS entry.
+ * WARNING: The returned pointer is not protected. The caller must ensure
+ * that the entry is not freed while using it, or hold qos_mutex during use.
+ */
 struct atm_mpoa_qos *atm_mpoa_search_qos(__be32 dst_ip)
 {
  struct atm_mpoa_qos *qos;

- qos = qos_head;
- while (qos) {
- if (qos->ipaddr == dst_ip)
- break;
- qos = qos->next;
- }
+ mutex_lock(&qos_mutex);
+ qos = __atm_mpoa_search_qos(dst_ip);
+ mutex_unlock(&qos_mutex);

  return qos;
 }

 /*
  * Overwrites the old entry or makes a new one.
  */
 struct atm_mpoa_qos *atm_mpoa_add_qos(__be32 dst_ip, struct atm_qos *qos)
 {
  struct atm_mpoa_qos *entry;
+ struct atm_mpoa_qos *new;

- entry = atm_mpoa_search_qos(dst_ip);
- if (entry != NULL) {
+ /* Fast path: update existing entry */
+ mutex_lock(&qos_mutex);
+ entry = __atm_mpoa_search_qos(dst_ip);
+ if (entry) {
  entry->qos = *qos;
+ mutex_unlock(&qos_mutex);
  return entry;
  }
+ mutex_unlock(&qos_mutex);

- entry = kmalloc(sizeof(struct atm_mpoa_qos), GFP_KERNEL);
- if (entry == NULL) {
+ /* Allocate outside lock */
+ new = kmalloc(sizeof(*new), GFP_KERNEL);
+ if (!new) {
  pr_info("mpoa: out of memory\n");
- return entry;
+ return NULL;
  }

- entry->ipaddr = dst_ip;
- entry->qos = *qos;
+ new->ipaddr = dst_ip;
+ new->qos = *qos;

+ /* Re-check under lock to avoid duplicates */
  mutex_lock(&qos_mutex);
- entry->next = qos_head;
- qos_head = entry;
+ entry = __atm_mpoa_search_qos(dst_ip);
+ if (entry) {
+ entry->qos = *qos;
+ mutex_unlock(&qos_mutex);
+ kfree(new);
+ return entry;
+ }
+
+ new->next = qos_head;
+ qos_head = new;
  mutex_unlock(&qos_mutex);

- return entry;
+ return new;
 }

 /*
  * Returns 0 for failure, 1 for success
  */
 int atm_mpoa_delete_qos(struct atm_mpoa_qos *entry)
 {
  struct atm_mpoa_qos *curr;
+ int ret = 0;

  if (entry == NULL)
  return 0;

+ mutex_lock(&qos_mutex);
+
  if (entry == qos_head) {
  qos_head = qos_head->next;
- kfree(entry);
- return 1;
+ ret = 1;
+ goto out_free;
  }

  curr = qos_head;
  while (curr != NULL) {
  if (curr->next == entry) {
  curr->next = entry->next;
- kfree(entry);
- return 1;
+ ret = 1;
+ goto out_free;
  }
  curr = curr->next;
  }

- return 0;
+out:
+ mutex_unlock(&qos_mutex);
+ return ret;
+
+out_free:
+ mutex_unlock(&qos_mutex);
+ kfree(entry);
+ return ret;
 }

 /* this is buggered - we need locking for qos_head */
 void atm_mpoa_disp_qos(struct seq_file *m)
 {
  struct atm_mpoa_qos *qos;

  seq_printf(m, "QoS entries for shortcuts:\n");
  seq_printf(m, "IP address\n  TX:max_pcr pcr     min_pcr max_cdv
max_sdu\n  RX:max_pcr pcr     min_pcr max_cdv max_sdu\n");

+ mutex_lock(&qos_mutex);
  qos = qos_head;
  while (qos != NULL) {
  seq_printf(m, "%pI4\n     %-7d %-7d %-7d %-7d %-7d\n     %-7d %-7d
%-7d %-7d %-7d\n",
@@ -250,6 +273,7 @@ void atm_mpoa_disp_qos(struct seq_file *m)
     qos->qos.rxtp.max_cdv,
     qos->qos.rxtp.max_sdu);
  qos = qos->next;
  }
+ mutex_unlock(&qos_mutex);
 }

 static struct net_device *find_lec_by_itfnum(int itf)
@@ -1524,8 +1548,10 @@ static void __exit atm_mpoa_cleanup(void)
  mpc = tmp;
  }

+ mutex_lock(&qos_mutex);
  qos = qos_head;
  qos_head = NULL;
+ mutex_unlock(&qos_mutex);
  while (qos != NULL) {
  nextqos = qos->next;
  dprintk("freeing qos entry %p\n", qos);
--

