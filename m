Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63384750367
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGLJkw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGLJkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 05:40:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9D1734
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 02:40:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977e0fbd742so839749266b.2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689154843; x=1691746843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2i1XP2A0HKCYlf05QxH688mlDCGuWIn9TvOMRqdls8=;
        b=a1MOscWWNBZ5HUCRZrW8jTUnRu9TC7zwd+t2IOESZJxrr8BGJvIPWmAdDPqJ19HSb4
         GN44Orowm1cxHvP6U0Oyys6b0XEgfaAR05bXCrQmkmz3Or/NvJnK1c7HXBMHwBy11TOy
         dWkXtF+iAsLkkRZGgxZuRsx0Ii29Vz2KDa7IShGAw59hUEoZyfQGE9fFH6uLw5YpMomN
         kho2Egwa/Oeb4Z5ZRfn/IwonMJU7F7vI+bChbqg/zriGqc2LnvJ5gPQBOoGhBvQrhQ01
         9Gz2MHELouRA1pvEhIZPhQ+fq6/uvhIeNZC7ylvOOcX0ThXn9UPzTipbux3s2CVncnZU
         bL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154843; x=1691746843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2i1XP2A0HKCYlf05QxH688mlDCGuWIn9TvOMRqdls8=;
        b=Q4aAXHcz6butCi2y2c/7gOSoHwJoHXKnU56fmHa3quwDJWGPO2wT22tx42KXgb9zBS
         b63hQaAti7LKmHxohvNiLC8/T17q9SagDuP3gjlq3ekFxe1GwG/ZbGaEG2qnhLw5rNIa
         E8Br5WnpEvdrXU+Zi+Y14j5iy86F9XriMPc6suUCiRDyiT5jlhAYwYMwHlIBwalEvcTI
         6GzvPhDJD1lW03t7jqhzBkwGrVeWv3TnCBOMVxQfBL2/yuW4OsFe+aPfLqRC16U2iui+
         KCK2pPrGsa1RuldkrfDVGrp31nrHSuwzfhHHNyODXVjDSd/FjL1fMQ/ANWfyyLuZTAtO
         P4HQ==
X-Gm-Message-State: ABy/qLY2HBO4K9UEV5nF04SL+H5BD0SMO4/TUGgRF3zjm+BWbAAs8Ab1
        QlUEPAb7IfCaOaebIl+OWtdrqCN+ouKQxvMKZHLr2dEhvM40hXYKc9TKgQ==
X-Google-Smtp-Source: APBJJlEaiJfeuPzEZDsr+8Zp5GpNx1Nx7bEq3337a4Bn/+AdkhQXEJkL2rcElQOYo1rfMpdtIFVTN7KzHT3sT8B4poA=
X-Received: by 2002:a17:906:3605:b0:970:1b2d:45cc with SMTP id
 q5-20020a170906360500b009701b2d45ccmr18002142ejb.57.1689154843534; Wed, 12
 Jul 2023 02:40:43 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 12 Jul 2023 10:40:32 +0100
Message-ID: <CAN+4W8j6G4f9Pg+rb+gcO06OU8ovudhbwXj0+E8Gg09zrozcZQ@mail.gmail.com>
Subject: linux-5.10.y: please backport to fix BPF selftest breakage
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi stable team,

Building BPF selftests on 5.10.186 currently causes the following compile error:

$ make -C tools/testing/selftests/bpf
...
  BINARY   test_verifier
In file included from
/usr/src/linux-5.10.186/tools/testing/selftests/bpf/verifier/tests.h:59,
                 from test_verifier.c:355:
/usr/src/linux-5.10.186/tools/testing/selftests/bpf/verifier/ref_tracking.c:935:10:
error: 'struct bpf_test' has no member named 'fixup_map_ringbuf'; did
you mean 'fixup_map_in_map'?
  935 |         .fixup_map_ringbuf = { 11 },
      |          ^~~~~~~~~~~~~~~~~
      |          fixup_map_in_map

The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
verifier test for release_reference()") in your tree.

Seems like at least commit 4237e9f4a962 ("selftests/bpf: Add verifier
test for PTR_TO_MEM spill") is required for the build to succeed.

I previously reported this but things probably fell through the
cracks: https://lore.kernel.org/stable/CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com/#t

Thanks!
Lorenz
