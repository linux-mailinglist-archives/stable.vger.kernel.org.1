Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA87C8329
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJMKfX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJMKfW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 06:35:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D2AD
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697193321; x=1728729321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRD1R6Bcz0Q2LAjc9mqGk0QA/wUXw3PBDTNmpI6pe/I=;
  b=mYnAWd2JRyNxFpoVdKqnJzG5P5X5/gJWqyK2BG1pt9tuZuK6t9iokQVv
   UL7kGgCBUqFU6Th0lgarUm1iFk2fJuDq5BKWL5in9dWafUZYA0JJhCp2f
   Jhl9h6PpoSxbDmfEuEl1azLAVecNKTl8t/JRzQx+XwWwqg2PQ57e9toul
   ShhAje6UBk+noIhATabt1+QGUkOL7n7w/Pfq3u03JJx9knf8fZmpaH9wm
   MYa+F+1ePPzKX5PWa4ZOXAEVWym3tFaak60cw3t6qVnTKyIBnh7mPhD1z
   oXlarUPDu+TL7lQhzRj7vGMDjfpXi+tZDdtqlVZDFvNXPgQ+jA+wyu18j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375502104"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="375502104"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731321136"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="731321136"
Received: from kesooi-mobl1.gar.corp.intel.com (HELO intel.com) ([10.215.155.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:35:13 -0700
Date:   Fri, 13 Oct 2023 12:35:08 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        John Harrison <john.c.harrison@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        stable@vger.kernel.org, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/i915: Flush WC GGTT only on required platforms
Message-ID: <ZSkdXLTqGY0z/PCI@ashyti-mobl2.lan>
References: <20231013103140.12192-1-nirmoy.das@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013103140.12192-1-nirmoy.das@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nirmoy,

On Fri, Oct 13, 2023 at 12:31:40PM +0200, Nirmoy Das wrote:
> gen8_ggtt_invalidate() is only needed for limitted set of platforms

/limitted/limited/

> where GGTT is mapped as WC otherwise this can cause unwanted
> side-effects on XE_HP platforms where GFX_FLSH_CNTL_GEN6 is not
> valid.
> 
> Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: John Harrison <john.c.harrison@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.2+
> Suggested-by: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>

Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
