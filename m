Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1C703D0F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjEOSze (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjEOSzd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:55:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DD15EDA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684176932; x=1715712932;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ctODLCKWsH3VS23Lm6VTcPXyI+f8wz/0yaDG33pw/e4=;
  b=jLg0GaSSzlUvEkrtRZ3Csf6JzHpk7r7Pf1TZBolGC5SicLoQaWpV1LeP
   mxBy/UWcPjns+/sJGktAV/AB8YcIoMXofeMi1yjFYCJniogPC+Nrv0BPs
   SYhRvbMPosbXu/4vl2JW0e6d/l/hB6pbfdVKTOSj3PmnkDN5khyLO4Pia
   54zsajB6St+dMvJLhAW19RA5+QT4f1e0RXs5RrCbTS6XfI1Bo/OQd5Ocx
   1XDwW1yIkBNlc02/Iq/Fzkl9jkFomKuISE0ZYjO0EcdevV1ghfrFA9+5L
   R1Vhj/N1Rnzwj+Uq5DmL/eqIGZSigQjR8vd0HZark7inK9CIQLT1k4/Rf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353559335"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="353559335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 11:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="733987600"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="733987600"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2023 11:55:30 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pydM2-0006Ys-2L;
        Mon, 15 May 2023 18:55:30 +0000
Date:   Tue, 16 May 2023 02:54:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to
 scan present CPUs
Message-ID: <ZGJ/6Pmxl7bqOPkQ@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684172191-17100-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
Link: https://lore.kernel.org/stable/1684172191-17100-1-git-send-email-mikelley%40microsoft.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



