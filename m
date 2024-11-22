Return-Path: <stable+bounces-94633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A773D9D648E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDEF1606B4
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D01DF24D;
	Fri, 22 Nov 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBC/nEAl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5F64A8F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303583; cv=none; b=dwIWV4HVjydSWZEh4YflPJOQexAft1QjZGMFnD9y8rTprAy2A4TAH7WZ3js27z2z6j+CaOpZGNF+sVVkKwLPZpz97eh9lEeuFRh2fO0vDHMyM6oWIFDK66QBpvr5bInrtAAPySE5O9w+9BIi2hDo9ct7S/TvrE+4i7vLhdS75TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303583; c=relaxed/simple;
	bh=PXL5b+A1gbG8Q2hfDqBEP8b3R/ZSEYfS+rLwQDVAj08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXrrYV6hqTJKF5MaA/oj0jyc8u+MM3vNfewK0M+VRMGDiidltwKq390qyBkvSBek4w2o76yvbyfhQV/qqEaa7ZM7VVJ1ul0/7ZRuCnCGJ+DUhZZg5bu5GtsiuMnwp+2gfUw4Ny+5ck089GvxfIwf7I5MY8EYJvH58zV9DQg06fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBC/nEAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E2C4CECE;
	Fri, 22 Nov 2024 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732303582;
	bh=PXL5b+A1gbG8Q2hfDqBEP8b3R/ZSEYfS+rLwQDVAj08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBC/nEAlfdwbgWU+dHPDdZ2ZKUCO2DDmVU01xbF0QKeNa+RUY/6ufVC4nRAohNIMS
	 dU7oL5chFnGLMzVZxsp2M2idXBrrhiUuui7XOte2nFU+zl+zh/757uCBwECGjtT7lx
	 aqldV4nCimVIgBACu3UuNhTbz7Oz01epLsYrCunM49P9+pB6wYa6Qz8Kyg797bdX9f
	 qpMMaK6jD/TZXWmt2wcLEpQ7gTRIvCtUMGj0aT7LbCI/xwhX2O/SPQpRik6J2U3KCG
	 bYqBhgtmA1CMMNOtclWLu7gEjUV1UCfcaIS4uGEreTomY6jhU56I/qBtZBVuSE/D5I
	 L9jPt4bw+t3Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] xhci: dbc: Fix STALL transfer event handling
Date: Fri, 22 Nov 2024 14:26:20 -0500
Message-ID: <20241122123135-6b1f0b22c638f323@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122154146.3694205-1-mathias.nyman@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9044ad57b60b0556d42b6f8aa218a68865e810a4


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 11:40:04.900767226 -0500
+++ /tmp/tmp.eypkTL84u1	2024-11-22 11:40:04.892785429 -0500
@@ -28,18 +28,16 @@
 Closes: https://lore.kernel.org/linux-usb/20240725074857.623299-1-ukaszb@chromium.org/
 Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
 Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
-Link: https://lore.kernel.org/r/20240905143300.1959279-2-mathias.nyman@linux.intel.com
-Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 ---
- drivers/usb/host/xhci-dbgcap.c | 133 ++++++++++++++++++++-------------
+ drivers/usb/host/xhci-dbgcap.c | 132 ++++++++++++++++++++-------------
  drivers/usb/host/xhci-dbgcap.h |   2 +-
- 2 files changed, 83 insertions(+), 52 deletions(-)
+ 2 files changed, 83 insertions(+), 51 deletions(-)
 
 diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
-index 161c09953c4e0..241d7aa1fbc20 100644
+index b40d9238d447..69067015f0d5 100644
 --- a/drivers/usb/host/xhci-dbgcap.c
 +++ b/drivers/usb/host/xhci-dbgcap.c
-@@ -173,16 +173,18 @@ static void xhci_dbc_giveback(struct dbc_request *req, int status)
+@@ -158,16 +158,18 @@ static void xhci_dbc_giveback(struct dbc_request *req, int status)
  	spin_lock(&dbc->lock);
  }
  
@@ -61,7 +59,7 @@
  	xhci_dbc_giveback(req, -ESHUTDOWN);
  }
  
-@@ -649,7 +651,6 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
+@@ -637,7 +639,6 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
  	case DS_DISABLED:
  		return;
  	case DS_CONFIGURED:
@@ -69,8 +67,8 @@
  		if (dbc->driver->disconnect)
  			dbc->driver->disconnect(dbc);
  		break;
-@@ -669,6 +670,23 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
- 	pm_runtime_put_sync(dbc->dev); /* note, was self.controller */
+@@ -657,6 +658,23 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
+ 	}
  }
  
 +static void
@@ -93,7 +91,7 @@
  static void
  dbc_handle_port_status(struct xhci_dbc *dbc, union xhci_trb *event)
  {
-@@ -697,6 +715,7 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
+@@ -685,6 +703,7 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
  	struct xhci_ring	*ring;
  	int			ep_id;
  	int			status;
@@ -101,7 +99,7 @@
  	u32			comp_code;
  	size_t			remain_length;
  	struct dbc_request	*req = NULL, *r;
-@@ -706,8 +725,30 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
+@@ -694,8 +713,30 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
  	ep_id		= TRB_TO_EP_ID(le32_to_cpu(event->generic.field[3]));
  	dep		= (ep_id == EPID_OUT) ?
  				get_out_ep(dbc) : get_in_ep(dbc);
@@ -132,7 +130,7 @@
  	switch (comp_code) {
  	case COMP_SUCCESS:
  		remain_length = 0;
-@@ -718,31 +759,49 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
+@@ -706,31 +747,49 @@ static void dbc_handle_xfer_event(struct xhci_dbc *dbc, union xhci_trb *event)
  	case COMP_TRB_ERROR:
  	case COMP_BABBLE_DETECTED_ERROR:
  	case COMP_USB_TRANSACTION_ERROR:
@@ -198,7 +196,7 @@
  	ring->num_trbs_free++;
  	req->actual = req->length - remain_length;
  	xhci_dbc_giveback(req, status);
-@@ -762,7 +821,6 @@ static void inc_evt_deq(struct xhci_ring *ring)
+@@ -750,7 +809,6 @@ static void inc_evt_deq(struct xhci_ring *ring)
  static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
  {
  	dma_addr_t		deq;
@@ -206,7 +204,7 @@
  	union xhci_trb		*evt;
  	u32			ctrl, portsc;
  	bool			update_erdp = false;
-@@ -814,43 +872,17 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
+@@ -802,43 +860,17 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
  			return EVT_DISC;
  		}
  
@@ -253,16 +251,8 @@
  	default:
  		dev_err(dbc->dev, "Unknown DbC state %d\n", dbc->state);
  		break;
-@@ -939,7 +971,6 @@ static const char * const dbc_state_strings[DS_MAX] = {
- 	[DS_ENABLED] = "enabled",
- 	[DS_CONNECTED] = "connected",
- 	[DS_CONFIGURED] = "configured",
--	[DS_STALLED] = "stalled",
- };
- 
- static ssize_t dbc_show(struct device *dev,
 diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
-index 0118c6288a3cc..97c5dc290138b 100644
+index 76170d7a7e7c..2de0dc49a3e9 100644
 --- a/drivers/usb/host/xhci-dbgcap.h
 +++ b/drivers/usb/host/xhci-dbgcap.h
 @@ -81,7 +81,6 @@ enum dbc_state {
@@ -270,10 +260,10 @@
  	DS_CONNECTED,
  	DS_CONFIGURED,
 -	DS_STALLED,
- 	DS_MAX
  };
  
-@@ -90,6 +89,7 @@ struct dbc_ep {
+ struct dbc_ep {
+@@ -89,6 +88,7 @@ struct dbc_ep {
  	struct list_head		list_pending;
  	struct xhci_ring		*ring;
  	unsigned int			direction:1;
@@ -281,3 +271,6 @@
  };
  
  #define DBC_QUEUE_SIZE			16
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

Build Errors:
Build error for stable/linux-6.6.y:
    lib/test_dhry.o: warning: objtool: dhry() falls through to next function dhry_run_set.cold()
    drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
    drivers/usb/host/xhci-dbgcap.c:976:14: error: 'DS_STALLED' undeclared (first use in this function); did you mean 'DS_ENABLED'?
      976 |         case DS_STALLED:
          |              ^~~~~~~~~~
          |              DS_ENABLED
    drivers/usb/host/xhci-dbgcap.c:976:14: note: each undeclared identifier is reported only once for each function it appears in
    make[5]: *** [scripts/Makefile.build:243: drivers/usb/host/xhci-dbgcap.o] Error 1
    make[5]: Target 'drivers/usb/host/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:480: drivers/usb/host] Error 2
    make[4]: Target 'drivers/usb/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:480: drivers/usb] Error 2
    make[3]: Target 'drivers/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1921: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-6.1.y:
    drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
    drivers/usb/host/xhci-dbgcap.c:976:14: error: 'DS_STALLED' undeclared (first use in this function); did you mean 'DS_ENABLED'?
      976 |         case DS_STALLED:
          |              ^~~~~~~~~~
          |              DS_ENABLED
    drivers/usb/host/xhci-dbgcap.c:976:14: note: each undeclared identifier is reported only once for each function it appears in
    make[4]: *** [scripts/Makefile.build:250: drivers/usb/host/xhci-dbgcap.o] Error 1
    make[4]: Target 'drivers/usb/host/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:503: drivers/usb/host] Error 2
    make[3]: Target 'drivers/usb/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/usb] Error 2
    make[2]: Target 'drivers/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.15.y:
    drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
    drivers/usb/host/xhci-dbgcap.c:976:14: error: 'DS_STALLED' undeclared (first use in this function); did you mean 'DS_ENABLED'?
      976 |         case DS_STALLED:
          |              ^~~~~~~~~~
          |              DS_ENABLED
    drivers/usb/host/xhci-dbgcap.c:976:14: note: each undeclared identifier is reported only once for each function it appears in
    make[3]: *** [scripts/Makefile.build:289: drivers/usb/host/xhci-dbgcap.o] Error 1
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:552: drivers/usb/host] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: drivers/usb] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1906: drivers] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.10.y:
    In file included from ./include/linux/kernel.h:15,
                     from ./include/linux/list.h:9,
                     from ./include/linux/kobject.h:19,
                     from ./include/linux/of.h:17,
                     from ./include/linux/clk-provider.h:9,
                     from drivers/clk/qcom/clk-rpmh.c:6:
    drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
    ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
          |                                   ^~
    ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
       26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
          |                  ^~~~~~~~~~~
    ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
       36 |         __builtin_choose_expr(__safe_cmp(x, y), \
          |                               ^~~~~~~~~~
    ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
       45 | #define min(x, y)       __careful_cmp(x, y, <)
          |                         ^~~~~~~~~~~~~
    drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
      273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
          |                     ^~~
    In file included from ./include/linux/mm.h:30,
                     from ./include/linux/pagemap.h:8,
                     from ./include/linux/buffer_head.h:14,
                     from fs/udf/udfdecl.h:12,
                     from fs/udf/super.c:41:
    fs/udf/super.c: In function 'udf_fill_partdesc_info':
    ./include/linux/overflow.h:70:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
       70 |         (void) (&__a == &__b);                  \
          |                      ^~
    fs/udf/super.c:1155:21: note: in expansion of macro 'check_add_overflow'
     1155 |                 if (check_add_overflow(map->s_partition_len,
          |                     ^~~~~~~~~~~~~~~~~~
    drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
    drivers/usb/host/xhci-dbgcap.c:1029:14: error: 'DS_STALLED' undeclared (first use in this function); did you mean 'DS_ENABLED'?
     1029 |         case DS_STALLED:
          |              ^~~~~~~~~~
          |              DS_ENABLED
    drivers/usb/host/xhci-dbgcap.c:1029:14: note: each undeclared identifier is reported only once for each function it appears in
    make[3]: *** [scripts/Makefile.build:286: drivers/usb/host/xhci-dbgcap.o] Error 1
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: drivers/usb/host] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: drivers/usb] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1832: drivers] Error 2
    make: Target '__all' not remade because of errors.

