Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B01799180
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 23:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjIHV34 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 17:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIHV3z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 17:29:55 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D4DC
        for <stable@vger.kernel.org>; Fri,  8 Sep 2023 14:29:51 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aa1443858eso1808384b6e.3
        for <stable@vger.kernel.org>; Fri, 08 Sep 2023 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=primegateways-com.20230601.gappssmtp.com; s=20230601; t=1694208591; x=1694813391; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sfo0ca1vDlfKhYRJnHj5ylYXxOZwpvexE7Z/c6pNCg=;
        b=ajYyZvYzEKXTLoZFTbtB94mDlAwqL9+smXPR3KeobqWdz6j/FJIAMmXvDyrpwy3H1m
         nGLDj9Y8dPJchyP3TKWTyOTs6wz7ig11be4mYNB3Y3xyb6gv5UIBpjsH6/w8i1k5KH8j
         oPXz7k/Vo31q448HNoTWQU7ra37sa3lJABAeN6GdJIMLEgkTPXFKjB9dyUJ/awX2efuI
         je0ocOVFIa7VtCmY/iK/nf/o3YqtdMgR5xyOZ0TXaM1ALGUtoHxUWPpTMJgxfB5JjmvH
         W5sO8CmWyc4v19czedm1iUW9AfDZAMFXl7pbj+qb/RnppD4/wuQV9nePxsBbgWHXbHdg
         0NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694208591; x=1694813391;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sfo0ca1vDlfKhYRJnHj5ylYXxOZwpvexE7Z/c6pNCg=;
        b=GFVVnIaMsBYi8FuEE4zn/azZoW5EiiDTRJsFZyvrNwPo48eVLrQjfi9kJ1/yZNMQfy
         glygXb8lwBAWLtJBrtEbG2/ONo9Q8M9M5fB6r7lxFM+GbZvA8qubr9IP63q3nBqbviXj
         qVbzmx1RHKAhHpB1gQzABs9g2hYSnh0t0bV425/GiGOYXMx6Atdj75Sf67CqlJEKlXfo
         IkCTpXrw0rBQVBdS/VkG0sNPseabEhK+PMkcL934ALjmmhevWOFMhdlRSjnA+OIQNxYX
         b8mcBPVrRZtqGIY2kalgoRkh87TaZtLdAZclfkuJ3KaZ0DTfVKjgdAl5Em776lsAxqFN
         lEMw==
X-Gm-Message-State: AOJu0YyL+QlI4wftPg76MsCe2e7SVX3Kcl6KV1zj/gpBW2UySHINqyPH
        Rr2yJChOtYV1ag5ssd2Aum3ALMTyjws/rehCoY/hHw==
X-Google-Smtp-Source: AGHT+IEOarJrM8z6e9EEcPh37drKQ4NdYuuCsI6Nkm4bsRl6aiFP22u3a4Gx7eHJrTwgf9up7F9L4Y3ci8T5wgCVZP4=
X-Received: by 2002:a05:6871:b1e:b0:1b7:72bb:c67b with SMTP id
 fq30-20020a0568710b1e00b001b772bbc67bmr4536552oab.29.1694208591001; Fri, 08
 Sep 2023 14:29:51 -0700 (PDT)
MIME-Version: 1.0
From:   Kimberly Taylor <kimberly@primegateways.com>
Date:   Fri, 8 Sep 2023 16:29:39 -0500
Message-ID: <CAP-cS8sNA3+N974YHQtz=+G9-DtmuBMkYNGdxjtoMkt4HGFFrg@mail.gmail.com>
Subject: RE: AWS re:Invent Attendees Email list- 2023
To:     Kimberly Taylor <kimberly@primegateways.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,FILL_THIS_FORM,FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Would you be interested in acquiring AWS re:Invent Attendees Data List 2023?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts: - 40,777
Cost: $1,977

Kind Regards,
Kimberly Taylor
Marketing Coordinator
