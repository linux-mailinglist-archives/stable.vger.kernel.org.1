Return-Path: <stable+bounces-244963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMOEAThR/2nn4gAAu9opvQ
	(envelope-from <stable+bounces-244963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323450043D
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57681300D149
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187E2253EE;
	Sat,  9 May 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeU30zej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512A185B48
	for <stable@vger.kernel.org>; Sat,  9 May 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340146; cv=none; b=grpBlAwHog4xdAUBpp0UN3uGq5jew7wxs1QSPfkH9Nowp1aepBFW5b2Oxc4CgGzaGbg1/LU+AaZsM0Zt9KoAAV6o5YHfW1dp94q3qErRze1p0Sxd2cd0JJXrc/oyBdAzkdHCX8v92J3wztdpZHnXYFLI4h71FYd5tKdrx6LpWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340146; c=relaxed/simple;
	bh=2OZyPJMc1XpuLeBu5kUlkaWQ+QOXJm8HobO+LkhONMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBp6ocnaAQCqcK33fe7XI78EuymrLN4RDwKxp9gFpIXV4mSVK/UBNfFOZwENCGFt8rPnqVdLauEqlOAxxA5yw8w0SX3PGEtyup7Lz9jq+Zgl57aDSzwtK7f+qdKlv8IhREmiOsDVkN9zAt0949GTO6/ndW9qYMG8uIzpVxQFU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeU30zej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67200C2BCB2;
	Sat,  9 May 2026 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778340145;
	bh=2OZyPJMc1XpuLeBu5kUlkaWQ+QOXJm8HobO+LkhONMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeU30zejrJjsdExNCUgUFL0jZwSktFagl/4TF9squtyjnSLw1ICcuSZWS36bkCAyF
	 OMUH2aSpjFgbnEf44VXSTHzLrji5Ol7Q1R6bXpZGatuTBlyMV16wtzGZhO8QK3X0oW
	 u5muRSQWHMDi4qrrcmUpqdesZlGO8QpfXNPv9/3UkKNfWvNoPhm39na2ozKdKPty6K
	 LPxCLTUmnyIUpbnkH2aDBLIXmkvy838LLXDd2brpWl6ecQoo0KzSIRMlehg+r8oKYX
	 K2g0AY+4J/RIFoKS0PKV34Fq97QsOkn3T7ezGxF5U/RQcosJze72ZppdxzNk3+x2iQ
	 W0hxniQwyFrQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ktest: Fixing indentation to match expected pattern
Date: Sat,  9 May 2026 11:22:21 -0400
Message-ID: <20260509152222.3511536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050401-payphone-celestial-4a77@gregkh>
References: <2026050401-payphone-celestial-4a77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7323450043D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244963-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eaglescrag.net:email]
X-Rspamd-Action: no action

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

[ Upstream commit 12d4cddda2043466a5af8fc0c49e49f24f1d4c59 ]

This is a followup to "ktest: Adding editor hints to improve
consistency" to actually adjust the existing indentation to match
the, now, expected pattern (first column 4 spaces, 2nd tab, 3rd
tab + 4 spaces, etc).  This should, at least help, keep things
consistent going forward now.

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 768059ede35f ("ktest: Fix the month in the name of the failure directory")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 186 +++++++++++++++++------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 512a3cc586fdd..1188de4bf89de 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -762,7 +762,7 @@ sub process_variables {
     # remove the space added in the beginning
     $retval =~ s/ //;
 
-    return "$retval"
+    return "$retval";
 }
 
 sub set_value {
@@ -1098,7 +1098,7 @@ sub __read_config {
 		    }
 		}
 	    }
-		
+
 	    if ( ! -r $file ) {
 		die "$name: $.: Can't read file $file\n$_";
 	    }
@@ -1189,13 +1189,13 @@ sub __read_config {
 }
 
 sub get_test_case {
-	print "What test case would you like to run?\n";
-	print " (build, install or boot)\n";
-	print " Other tests are available but require editing ktest.conf\n";
-	print " (see tools/testing/ktest/sample.conf)\n";
-	my $ans = <STDIN>;
-	chomp $ans;
-	$default{"TEST_TYPE"} = $ans;
+    print "What test case would you like to run?\n";
+    print " (build, install or boot)\n";
+    print " Other tests are available but require editing ktest.conf\n";
+    print " (see tools/testing/ktest/sample.conf)\n";
+    my $ans = <STDIN>;
+    chomp $ans;
+    $default{"TEST_TYPE"} = $ans;
 }
 
 sub read_config {
@@ -1526,13 +1526,13 @@ sub dodie {
 	    close O;
 	    close L;
 	}
-        send_email("KTEST: critical failure for test $i [$name]",
-                "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
+	send_email("KTEST: critical failure for test $i [$name]",
+	        "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
     }
 
     if ($monitor_cnt) {
-	    # restore terminal settings
-	    system("stty $stty_orig");
+	# restore terminal settings
+	system("stty $stty_orig");
     }
 
     if (defined($post_test)) {
@@ -1716,81 +1716,81 @@ sub wait_for_monitor {
 }
 
 sub save_logs {
-	my ($result, $basedir) = @_;
-	my @t = localtime;
-	my $date = sprintf "%04d%02d%02d%02d%02d%02d",
-		1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
+    my ($result, $basedir) = @_;
+    my @t = localtime;
+    my $date = sprintf "%04d%02d%02d%02d%02d%02d",
+	1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
 
-	my $type = $build_type;
-	if ($type =~ /useconfig/) {
-	    $type = "useconfig";
-	}
+    my $type = $build_type;
+    if ($type =~ /useconfig/) {
+	$type = "useconfig";
+    }
 
-	my $dir = "$machine-$test_type-$type-$result-$date";
+    my $dir = "$machine-$test_type-$type-$result-$date";
 
-	$dir = "$basedir/$dir";
+    $dir = "$basedir/$dir";
 
-	if (!-d $dir) {
-	    mkpath($dir) or
-		dodie "can't create $dir";
-	}
+    if (!-d $dir) {
+	mkpath($dir) or
+	    dodie "can't create $dir";
+    }
 
-	my %files = (
-		"config" => $output_config,
-		"buildlog" => $buildlog,
-		"dmesg" => $dmesg,
-		"testlog" => $testlog,
-	);
+    my %files = (
+	"config" => $output_config,
+	"buildlog" => $buildlog,
+	"dmesg" => $dmesg,
+	"testlog" => $testlog,
+    );
 
-	while (my ($name, $source) = each(%files)) {
-		if (-f "$source") {
-			cp "$source", "$dir/$name" or
-				dodie "failed to copy $source";
-		}
+    while (my ($name, $source) = each(%files)) {
+	if (-f "$source") {
+	    cp "$source", "$dir/$name" or
+		dodie "failed to copy $source";
 	}
+    }
 
-	doprint "*** Saved info to $dir ***\n";
+    doprint "*** Saved info to $dir ***\n";
 }
 
 sub fail {
 
-	if ($die_on_failure) {
-		dodie @_;
-	}
+    if ($die_on_failure) {
+	dodie @_;
+    }
 
-	doprint "FAILED\n";
+    doprint "FAILED\n";
 
-	my $i = $iteration;
+    my $i = $iteration;
 
-	# no need to reboot for just building.
-	if (!do_not_reboot) {
-	    doprint "REBOOTING\n";
-	    reboot_to_good $sleep_time;
-	}
+    # no need to reboot for just building.
+    if (!do_not_reboot) {
+	doprint "REBOOTING\n";
+	reboot_to_good $sleep_time;
+    }
 
-	my $name = "";
+    my $name = "";
 
-	if (defined($test_name)) {
-	    $name = " ($test_name)";
-	}
+    if (defined($test_name)) {
+	$name = " ($test_name)";
+    }
 
-	print_times;
+    print_times;
 
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "KTEST RESULT: TEST $i$name Failed: ", @_, "\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "KTEST RESULT: TEST $i$name Failed: ", @_, "\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
 
-	if (defined($store_failures)) {
-	    save_logs "fail", $store_failures;
-        }
+    if (defined($store_failures)) {
+	save_logs "fail", $store_failures;
+    }
 
-	if (defined($post_test)) {
-		run_command $post_test;
-	}
+    if (defined($post_test)) {
+	run_command $post_test;
+    }
 
-	return 1;
+    return 1;
 }
 
 sub run_command {
@@ -1991,9 +1991,9 @@ sub get_grub_index {
 	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
-        $command = $grub_bls_get;
-        $target = '^title=.*' . $grub_menu_qt;
-        $skip = '^title=';
+	$command = $grub_bls_get;
+	$target = '^title=.*' . $grub_menu_qt;
+	$skip = '^title=';
     } else {
 	return;
     }
@@ -2426,7 +2426,7 @@ sub check_buildlog {
 	while (<IN>) {
 	    if (/$check_build_re/) {
 		my $warning = process_warning_line $_;
-		
+
 		$warnings_list{$warning} = 1;
 	    }
 	}
@@ -2688,7 +2688,7 @@ sub success {
     doprint     "*******************************************\n";
 
     if (defined($store_successes)) {
-        save_logs "success", $store_successes;
+	save_logs "success", $store_successes;
     }
 
     if ($i != $opt{"NUM_TESTS"} && !do_not_reboot) {
@@ -3273,13 +3273,13 @@ sub run_config_bisect {
 
     $ret = run_config_bisect_test $config_bisect_type;
     if ($ret) {
-        doprint "NEW GOOD CONFIG ($pass)\n";
+	doprint "NEW GOOD CONFIG ($pass)\n";
 	system("cp $output_config $tmpdir/good_config.tmp.$pass");
 	$pass++;
 	# Return 3 for good config
 	return 3;
     } else {
-        doprint "NEW BAD CONFIG ($pass)\n";
+	doprint "NEW BAD CONFIG ($pass)\n";
 	system("cp $output_config $tmpdir/bad_config.tmp.$pass");
 	$pass++;
 	# Return 4 for bad config
@@ -3398,7 +3398,7 @@ sub config_bisect {
     } while ($ret == 3 || $ret == 4);
 
     if ($ret == 2) {
-        config_bisect_end "$good_config.tmp", "$bad_config.tmp";
+	config_bisect_end "$good_config.tmp", "$bad_config.tmp";
     }
 
     return $ret if ($ret < 0);
@@ -3578,7 +3578,6 @@ sub read_kconfig {
     my $cont = 0;
     my $line;
 
-
     if (! -f $kconfig) {
 	doprint "file $kconfig does not exist, skipping\n";
 	return;
@@ -3687,7 +3686,7 @@ sub read_depends {
 
     if (! -f $kconfig && $arch =~ /\d$/) {
 	my $orig = $arch;
- 	# some subarchs have numbers, truncate them
+	# some subarchs have numbers, truncate them
 	$arch =~ s/\d*$//;
 	$kconfig = "$builddir/arch/$arch/Kconfig";
 	if (! -f $kconfig) {
@@ -3883,7 +3882,7 @@ sub make_min_config {
     foreach my $config (@config_keys) {
 	my $kconfig = chomp_config $config;
 	if (!defined $depcount{$kconfig}) {
-		$depcount{$kconfig} = 0;
+	    $depcount{$kconfig} = 0;
 	}
     }
 
@@ -3985,13 +3984,13 @@ sub make_min_config {
 	my $failed = 0;
 	build "oldconfig" or $failed = 1;
 	if (!$failed) {
-		start_monitor_and_install or $failed = 1;
+	    start_monitor_and_install or $failed = 1;
 
-		if ($type eq "test" && !$failed) {
-		    do_run_test or $failed = 1;
-		}
+	    if ($type eq "test" && !$failed) {
+		do_run_test or $failed = 1;
+	    }
 
-		end_monitor;
+	    end_monitor;
 	}
 
 	$in_bisect = 0;
@@ -4308,8 +4307,8 @@ sub cancel_test {
     }
     if ($email_when_canceled) {
 	my $name = get_test_name;
-        send_email("KTEST: Your [$name] test was cancelled",
-                "Your test started at $script_start_time was cancelled: sig int");
+	send_email("KTEST: Your [$name] test was cancelled",
+	        "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
 }
@@ -4357,15 +4356,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     # The first test may override the PRE_KTEST option
     if ($i == 1) {
-        if (defined($pre_ktest)) {
-            doprint "\n";
-            run_command $pre_ktest;
-        }
-        if ($email_when_started) {
+	if (defined($pre_ktest)) {
+	    doprint "\n";
+	    run_command $pre_ktest;
+	}
+	if ($email_when_started) {
 	    my $name = get_test_name;
-            send_email("KTEST: Your [$name] test was started",
-                "Your test was started on $script_start_time");
-        }
+	    send_email("KTEST: Your [$name] test was started",
+	        "Your test was started on $script_start_time");
+	}
     }
 
     # Any test can override the POST_KTEST option
@@ -4537,12 +4536,11 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
     run_command $switch_to_good;
 }
 
-
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
     send_email("KTEST: Your test has finished!",
-            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+	    "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 
 if (defined($opt{"LOG_FILE"})) {
-- 
2.53.0


